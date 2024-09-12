package RP2350.I2C
   with Pure, SPARK_Mode => On
is
   type CON_Register is record
      STOP_DET_IF_MASTER_ACTIVE  : Boolean := False;
      RX_FIFO_FULL_HLD_CTRL      : Boolean := False;
      TX_EMPTY_CTRL              : Boolean := False;
      STOP_DET_IFADDRESSED       : Boolean := False;
      IC_SLAVE_DISABLE           : Boolean := True;
      IC_RESTART_EN              : Boolean := True;
      IC_10BITADDR_MASTER        : Boolean := False;
      IC_10BITADDR_SLAVE         : Boolean := False;
      SPEED                      : UInt2 := 2;
      MASTER_MODE                : Boolean := True;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for CON_Register use record
      STOP_DET_IF_MASTER_ACTIVE  at 0 range 10 .. 10;
      RX_FIFO_FULL_HLD_CTRL      at 0 range 9 .. 9;
      TX_EMPTY_CTRL              at 0 range 8 .. 8;
      STOP_DET_IFADDRESSED       at 0 range 7 .. 7;
      IC_SLAVE_DISABLE           at 0 range 6 .. 6;
      IC_RESTART_EN              at 0 range 5 .. 5;
      IC_10BITADDR_MASTER        at 0 range 4 .. 4;
      IC_10BITADDR_SLAVE         at 0 range 3 .. 3;
      SPEED                      at 0 range 1 .. 2;
      MASTER_MODE                at 0 range 0 .. 0;
   end record;

   type TAR_Register is record
      SPECIAL     : Boolean := False;
      GC_OR_START : Boolean := False;
      TAR         : UInt10 := 16#55#;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for TAR_Register use record
      SPECIAL     at 0 range 11 .. 11;
      GC_OR_START at 0 range 10 .. 10;
      TAR         at 0 range 0 .. 9;
   end record;

   type DATA_CMD_Register is record
      FIRST_DATA_BYTE   : Boolean := False;
      RESTART           : Boolean := False;
      STOP              : Boolean := False;
      CMD               : Boolean := False;
      DAT               : UInt8 := 0;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Effective_Reads,
           Async_Writers,
           Async_Readers,
           Object_Size => 32;
   for DATA_CMD_Register use record
      FIRST_DATA_BYTE   at 0 range 11 .. 11;
      RESTART           at 0 range 10 .. 10;
      STOP              at 0 range 9 .. 9;
      CMD               at 0 range 8 .. 8;
      DAT               at 0 range 0 .. 7;
   end record;

   type INTR_Register is record
      RESTART_DET : Boolean;
      GEN_CALL    : Boolean;
      START_DET   : Boolean;
      STOP_DET    : Boolean;
      ACTIVITY    : Boolean;
      RX_DONE     : Boolean;
      TX_ABRT     : Boolean;
      RD_REQ      : Boolean;
      TX_EMPTY    : Boolean;
      TX_OVER     : Boolean;
      RX_FULL     : Boolean;
      RX_OVER     : Boolean;
      RX_UNDER    : Boolean;
   end record
      with Volatile_Full_Access,
           Async_Writers,
           Object_Size => 32;
   for INTR_Register use record
      RESTART_DET at 0 range 12 .. 12;
      GEN_CALL    at 0 range 11 .. 11;
      START_DET   at 0 range 10 .. 10;
      STOP_DET    at 0 range 9 .. 9;
      ACTIVITY    at 0 range 8 .. 8;
      RX_DONE     at 0 range 7 .. 7;
      TX_ABRT     at 0 range 6 .. 6;
      RD_REQ      at 0 range 5 .. 5;
      TX_EMPTY    at 0 range 4 .. 4;
      TX_OVER     at 0 range 3 .. 3;
      RX_FULL     at 0 range 2 .. 2;
      RX_OVER     at 0 range 1 .. 1;
      RX_UNDER    at 0 range 0 .. 0;
   end record;

   type ENABLE_Register is record
      TX_CMD_BLOCK : Boolean := False;
      TX_ABORT     : Boolean := False;
      ENABLE       : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for ENABLE_Register use record
      TX_CMD_BLOCK at 0 range 2 .. 2;
      TX_ABORT     at 0 range 1 .. 1;
      ENABLE       at 0 range 0 .. 0;
   end record;

   type SDA_HOLD_Register is record
      SDA_RX_HOLD : UInt8 := 16#00#;
      SDA_TX_HOLD : UInt16 := 16#0001#;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for SDA_HOLD_Register use record
      SDA_RX_HOLD at 0 range 16 .. 23;
      SDA_TX_HOLD at 0 range 0 .. 15;
   end record;

   type I2C_Peripheral is record
      CON            : CON_Register;
      TAR            : TAR_Register;
      DATA_CMD       : DATA_CMD_Register;
      FS_SCL_LCNT    : UInt32 := 16#002F#;
      FS_SCL_HCNT    : UInt32 := 16#0006#;
      CLR_TX_ABRT    : UInt32;
      CLR_STOP_DET   : UInt32;
      RAW_INTR_STAT  : INTR_Register;
      ENABLE         : ENABLE_Register;
      SDA_HOLD       : SDA_HOLD_Register;
      TX_ABRT_SOURCE : UInt32;
      FS_SPKLEN      : UInt32 := 16#07#;
   end record
      with Volatile;
   for I2C_Peripheral use record
      CON            at 16#00# range 0 .. 31;
      TAR            at 16#04# range 0 .. 31;
      DATA_CMD       at 16#10# range 0 .. 31;
      FS_SCL_LCNT    at 16#18# range 0 .. 31;
      FS_SCL_HCNT    at 16#1C# range 0 .. 31;
      RAW_INTR_STAT  at 16#34# range 0 .. 31;
      CLR_TX_ABRT    at 16#54# range 0 .. 31;
      CLR_STOP_DET   at 16#60# range 0 .. 31;
      ENABLE         at 16#6C# range 0 .. 31;
      SDA_HOLD       at 16#7C# range 0 .. 31;
      TX_ABRT_SOURCE at 16#80# range 0 .. 31;
      FS_SPKLEN      at 16#A0# range 0 .. 31;
   end record;
end RP2350.I2C;
