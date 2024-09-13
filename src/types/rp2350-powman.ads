package RP2350.POWMAN
   with Pure, SPARK_Mode => On
is
   POWMAN_PASSWD : constant UInt16 := 16#5AFE#;

   type TIMER_Register is record
      PASSWD         : UInt16 := POWMAN_PASSWD;
      USE_GPIO_1HZ   : Boolean := False;
      USE_GPIO_1KHZ  : Boolean := False;
      USE_XOSC       : Boolean := False;
      USE_LPOSC      : Boolean := False;
      ALARM          : Boolean := False;
      PWRUP_ON_ALARM : Boolean := False;
      ALARM_ENAB     : Boolean := False;
      CLEAR          : Boolean := False;
      RUN            : Boolean := False;
      NONSEC_WRITE   : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for TIMER_Register use record
      PASSWD            at 0 range 16 .. 31;
      --  The following status fields are read-only and overlap with PASSWD,
      --  which is required for writes.
      --  USING_GPIO_1HZ    at 0 range 19 .. 19;
      --  USING_GPIO_1KHZ   at 0 range 18 .. 18;
      --  USING_LPOSC       at 0 range 17 .. 17;
      --  USING_XOSC        at 0 range 16 .. 16;
      USE_GPIO_1HZ      at 0 range 13 .. 13;
      USE_GPIO_1KHZ     at 0 range 10 .. 10;
      USE_XOSC          at 0 range 9 .. 9;
      USE_LPOSC         at 0 range 8 .. 8;
      ALARM             at 0 range 6 .. 6;
      PWRUP_ON_ALARM    at 0 range 5 .. 5;
      ALARM_ENAB        at 0 range 4 .. 4;
      CLEAR             at 0 range 2 .. 2;
      RUN               at 0 range 1 .. 1;
      NONSEC_WRITE      at 0 range 0 .. 0;
   end record;

   type POWMAN_Peripheral is record
      READ_TIME_UPPER   : UInt32;
      READ_TIME_LOWER   : UInt32;
      TIMER             : TIMER_Register;
   end record
      with Volatile;
   for POWMAN_Peripheral use record
      READ_TIME_UPPER   at 16#70# range 0 .. 31;
      READ_TIME_LOWER   at 16#74# range 0 .. 31;
      TIMER             at 16#88# range 0 .. 31;
   end record;
end RP2350.POWMAN;
