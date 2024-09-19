package body RP2350.Drivers.SPI
   with SPARK_Mode => Off --  XXX
is
   FIFO_Depth : constant := 8;

   procedure Set_Baudrate
      (Speed   : Positive;
       Freq_In : Positive)
   is
      Prescale : Natural := 2;
      Postdiv  : Natural := 256;
   begin
      while Prescale <= 254 loop
         exit when Freq_In < (Prescale + 2) * 256 * Speed;
         Prescale := Prescale + 2;
      end loop;
      if Prescale > 254 then
         raise Program_Error;
      end if;

      while Postdiv > 1 loop
         exit when Freq_In / (Prescale * (Postdiv - 1)) > Speed;
         Postdiv := Postdiv - 1;
      end loop;

      Periph.CPSR.CPSDVSR := UInt8 (Prescale);
      Periph.CR0.SCR := UInt8 (Postdiv - 1);
   end Set_Baudrate;

   procedure Initialize
      (Speed    : Positive;
       CLK_PERI : Positive)
   is
   begin
      Periph.CR1.SSE := False;
      Set_Baudrate (Speed, CLK_PERI);

      Periph.CR0 :=
         (SCR => 0,
          SPH => False,
          SPO => False,
          FRF => 2#00#,
          DSS => 2#0111#);
      Periph.CR1 :=
         (SOD => False,
          MS  => False,
          SSE => True,
          LBM => False);
   end Initialize;

   procedure Configure_Pin
      (IO_BANK   : in out RP2350.IO_BANK.IO_BANK_Peripheral;
       PADS_BANK : in out RP2350.PADS_BANK.PADS_BANK_Peripheral;
       Pin       : RP2350.IO_BANK.GPIO_Index)
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
      FUNCSEL : constant := 1;
   begin
      IO_BANK.GPIO (Pin).CTRL.FUNCSEL := FUNCSEL;
      PADS_BANK.GPIO (RP2350.PADS_BANK.GPIO_Index (Pin)) := Pad_Config;
   end Configure_Pin;

   function Is_Writable
      return Boolean
   is (Periph.SR.TNF);

   function Is_Readable
      return Boolean
   is (Periph.SR.RNE);

   procedure Write
      (Data : UInt8_Array)
   is
      Ignore : UInt32 with Volatile;
      Busy   : Boolean;
   begin
      for D of Data loop
         loop
            exit when Is_Writable;
         end loop;
         Periph.DR := UInt32 (D);
      end loop;

      while Is_Readable loop
         Ignore := Periph.DR;
      end loop;
      loop
         Busy := Periph.SR.BSY;
         exit when not Busy;
      end loop;
      while Is_Readable loop
         Ignore := Periph.DR;
      end loop;
   end Write;

   procedure Read
      (Data : out UInt8_Array)
   is
      TX_Data    : constant UInt8 := 16#FF#;
      RX_Remaining, TX_Remaining : Natural := Data'Length;
      I : Integer := Data'First;
   begin
      while RX_Remaining > 0 or else TX_Remaining > 0 loop
         if TX_Remaining > 0 and then
            Is_Writable and then
            RX_Remaining < (TX_Remaining - FIFO_Depth)
         then
            Periph.DR := UInt32 (TX_Data);
            TX_Remaining := TX_Remaining - 1;
         end if;

         if RX_Remaining > 0 and then
            Is_Readable
         then
            Data (I) := UInt8 (Periph.DR);
            I := I + 1;
            RX_Remaining := RX_Remaining - 1;
         end if;
      end loop;
   end Read;

   procedure Transfer
      (TX : UInt8_Array;
       RX : out UInt8_Array)
   is
      RX_Remaining, TX_Remaining : Natural := TX'Length;
      TX_Index : Integer := TX'First;
      RX_Index : Integer := RX'First;
   begin
      while RX_Remaining > 0 or else TX_Remaining > 0 loop
         if TX_Remaining > 0 and then
            Is_Writable and then
            RX_Remaining < (TX_Remaining + FIFO_Depth)
         then
            Periph.DR := UInt32 (TX (TX_Index));
            TX_Index := TX_Index + 1;
            TX_Remaining := TX_Remaining - 1;
         end if;

         if RX_Remaining > 0 and then
            Is_Readable
         then
            RX (RX_Index) := UInt8 (Periph.DR);
            RX_Index := RX_Index + 1;
            RX_Remaining := RX_Remaining - 1;
         end if;
      end loop;
   end Transfer;
end RP2350.Drivers.SPI;
