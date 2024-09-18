pragma Style_Checks ("M120");

package body RP2350.Drivers.I2C
   with SPARK_Mode => On
is
   Restart_On_Next : Boolean := False;

   procedure Initialize
      (Speed   : I2C_Speed := Standard;
       CLK_SYS : CLK_SYS_Frequency := 11e6)
   is
      Baudrate    : constant Natural := I2C_Speed'Enum_Rep (Speed);
      Period      : constant Natural := (Natural (CLK_SYS) + Baudrate / 2) / Baudrate;
      LCNT        : constant Natural := Period * 3 / 5;
      HCNT        : constant Natural := Period - LCNT;
      SDA_TX_HOLD : constant Natural :=
         ((Natural (CLK_SYS) * 3) / (if Baudrate < 1e6 then 10e6 else 25e6)) + 1;
   begin
      Periph.ENABLE := (others => False);
      Periph.CON := (TX_EMPTY_CTRL => True, others => <>);
      Periph.FS_SCL_HCNT := UInt32 (HCNT);
      Periph.FS_SCL_LCNT := UInt32 (LCNT);
      Periph.FS_SPKLEN := UInt32 (if LCNT < 16 then 1 else LCNT / 16);
      Periph.SDA_HOLD :=
         (SDA_RX_HOLD => 0,
          SDA_TX_HOLD => UInt16 (SDA_TX_HOLD));
      Periph.ENABLE.ENABLE := True;
      Restart_On_Next := False;
   end Initialize;

   procedure Configure_Pins
      (IO_BANK   : in out RP2350.IO_BANK.IO_BANK_Peripheral;
       PADS_BANK : in out RP2350.PADS_BANK.PADS_BANK_Peripheral;
       SDA       : RP2350.IO_BANK.GPIO_Index;
       SCL       : RP2350.IO_BANK.GPIO_Index)
   is
      Pad_Config : constant RP2350.PADS_BANK.GPIO_Register :=
         (ISO        => False,
          OD         => False,
          IE         => True,
          DRIVE      => 1,
          PUE        => True,
          PDE        => False,
          SCHMITT    => True,
          SLEWFAST   => False);
      FUNCSEL : constant := 3;
   begin
      IO_BANK.GPIO (SDA).CTRL.FUNCSEL := FUNCSEL;
      IO_BANK.GPIO (SCL).CTRL.FUNCSEL := FUNCSEL;
      PADS_BANK.GPIO (RP2350.PADS_BANK.GPIO_Index (SDA)) := Pad_Config;
      PADS_BANK.GPIO (RP2350.PADS_BANK.GPIO_Index (SCL)) := Pad_Config;
   end Configure_Pins;

   procedure Write
      (Addr    : UInt7;
       Data    : UInt8_Array;
       Error   : out Boolean;
       Stop    : Boolean := True)
   is
      TX_EMPTY, STOP_DET : Boolean;
      TX_ABRT_SOURCE : UInt32;
      Read_Clear : UInt32 with Unreferenced; --  with Volatile;
      Timeout, TX_Abort : Boolean := False;
   begin
      Periph.ENABLE.ENABLE := False;
      Periph.TAR := (TAR => UInt10 (Addr), others => <>);
      Periph.ENABLE.ENABLE := True;

      for I in Data'Range loop
         Periph.DATA_CMD :=
            (RESTART => (I = Data'First) and then Restart_On_Next,
             STOP    => (I = Data'Last) and then Stop,
             DAT     => Data (I),
             others  => <>);
         loop
            TX_EMPTY := Periph.RAW_INTR_STAT.TX_EMPTY;
            exit when TX_EMPTY;
            Timeout := Time_Exceeded;
            TX_Abort := Timeout;
            exit when Timeout;
         end loop;

         if not Timeout then
            TX_ABRT_SOURCE := Periph.TX_ABRT_SOURCE;
            if TX_ABRT_SOURCE > 0 then
               Read_Clear := Periph.CLR_TX_ABRT;
               TX_Abort := True;
            end if;

            if TX_Abort or else ((I = Data'Last) and then Stop) then
               loop
                  Timeout := Time_Exceeded;
                  TX_Abort := TX_Abort or else Timeout;
                  STOP_DET := Periph.RAW_INTR_STAT.STOP_DET;
                  exit when Timeout or else STOP_DET;
               end loop;

               if not Timeout then
                  Read_Clear := Periph.CLR_STOP_DET;
               end if;
            end if;
         end if;

         exit when TX_Abort;
      end loop;

      --  if TX_Abort then
      --     if Timeout then
      --        Status := Error_Timeout;
      --     elsif Abort_Reason.ABRT_7B_ADDR_NOACK then
      --        Status := Error_Bus;
      --        --  nothing connected?
      --     elsif Abort_Reason.ABRT_TXDATA_NOACK then
      --        Status := Error_Partial_Transmit;
      --     else
      --        Status := Error_Generic;
      --     end if;
      --  end if;

      Restart_On_Next := not Stop;
      Error := TX_Abort;
   end Write;

   procedure Read
      (Addr  : UInt7;
       Data  : out UInt8_Array;
       Error : out Boolean;
       Stop  : Boolean := True)
   is
      TX_BUFFER_DEPTH : constant := 16;
      Timeout      : Boolean;
      Read_Clear   : UInt32 with Unreferenced;
      RX_Abort     : Boolean := False;
      TXFLR, RXFLR : UInt32;
      TX_ABRT_SOURCE : UInt32;
   begin
      Periph.ENABLE.ENABLE := False;
      Periph.TAR := (TAR => UInt10 (Addr), others => <>);
      Periph.ENABLE.ENABLE := True;

      Data := (others => 0);

      for I in Data'Range loop
         loop
            TXFLR := Periph.TXFLR;
            exit when (TX_BUFFER_DEPTH - TXFLR) > 0;
         end loop;

         Periph.DATA_CMD :=
            (RESTART => (I = Data'First) and then Restart_On_Next,
             STOP    => (I = Data'Last) and then Stop,
             CMD     => True,
             others  => <>);

         loop
            TX_ABRT_SOURCE := Periph.TX_ABRT_SOURCE;
            if TX_ABRT_SOURCE > 0 then
               Read_Clear := Periph.CLR_TX_ABRT;
               RX_Abort := True;
            end if;
            Timeout := Time_Exceeded;
            RX_Abort := RX_Abort or else Timeout;
            RXFLR := Periph.RXFLR;
            exit when RX_Abort or else RXFLR > 0;
         end loop;

         exit when RX_Abort;

         Data (I) := Periph.DATA_CMD.DAT;
      end loop;

      Restart_On_Next := not Stop;
      Error := RX_Abort;
   end Read;
end RP2350.Drivers.I2C;
