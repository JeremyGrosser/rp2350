package RP2350.XOSC
   with Pure, SPARK_Mode => On
is
   ENABLE_KEY  : constant UInt12 := 16#FAB#;
   DISABLE_KEY : constant UInt12 := 16#D1E#;

   FREQ_1_15   : constant UInt12 := 16#AA0#;
   FREQ_10_30  : constant UInt12 := 16#AA1#;
   FREQ_25_60  : constant UInt12 := 16#AA2#;
   FREQ_40_100 : constant UInt12 := 16#AA3#;

   type CTRL_Register is record
      ENABLE      : UInt12;
      FREQ_RANGE  : UInt12;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for CTRL_Register use record
      ENABLE      at 0 range 12 .. 23;
      FREQ_RANGE  at 0 range 0 .. 11;
   end record;

   type STATUS_Register is record
      STABLE      : Boolean;
      BADWRITE    : Boolean;
      ENABLED     : Boolean;
      FREQ_RANGE  : UInt2;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for STATUS_Register use record
      STABLE      at 0 range 31 .. 31;
      BADWRITE    at 0 range 24 .. 24;
      ENABLED     at 0 range 12 .. 12;
      FREQ_RANGE  at 0 range 0 .. 1;
   end record;

   DORMANT  : constant UInt32 := 16#636F_6D61#;
   WAKE     : constant UInt32 := 16#7761_6B65#;

   type XOSC_Peripheral is record
      CTRL     : CTRL_Register;
      STATUS   : STATUS_Register;
      DORMANT  : UInt32 := WAKE;
      STARTUP  : UInt32 := 16#0000_00C4#;
      COUNT    : UInt32 := 16#0000_0000#;
   end record
      with Volatile;
   for XOSC_Peripheral use record
      CTRL     at 16#00# range 0 .. 31;
      STATUS   at 16#04# range 0 .. 31;
      DORMANT  at 16#08# range 0 .. 31;
      STARTUP  at 16#0C# range 0 .. 31;
      COUNT    at 16#10# range 0 .. 31;
   end record;
end RP2350.XOSC;
