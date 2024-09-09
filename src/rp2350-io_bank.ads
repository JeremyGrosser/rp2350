package RP2350.IO_BANK
   with Pure, SPARK_Mode => On
is

   type IO_BANK_GPIO_STATUS_Register is record
      IRQTOPROC   : Boolean;
      INFROMPAD   : Boolean;
      OETOPAD     : Boolean;
      OUTTOPAD    : Boolean;
   end record
      with Volatile_Full_Access,
           Async_Writers;
   for IO_BANK_GPIO_STATUS_Register use record
      IRQTOPROC   at 0 range 26 .. 26;
      INFROMPAD   at 0 range 17 .. 17;
      OETOPAD     at 0 range 13 .. 13;
      OUTTOPAD    at 0 range 9 .. 9;
   end record;

   type IO_BANK_GPIO_CTRL_Register is record
      IRQOVER     : UInt2;
      INOVER      : UInt2;
      OEOVER      : UInt2;
      OUTOVER     : UInt2;
      FUNCSEL     : UInt5 := 16#1F#;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers;
   for IO_BANK_GPIO_CTRL_Register use record
      IRQOVER  at 0 range 28 .. 29;
      INOVER   at 0 range 16 .. 17;
      OEOVER   at 0 range 14 .. 15;
      OUTOVER  at 0 range 12 .. 13;
      FUNCSEL  at 0 range 0 .. 4;
   end record;

   type IO_BANK_GPIO_Register is record
      STATUS : IO_BANK_GPIO_STATUS_Register;
      CTRL   : IO_BANK_GPIO_CTRL_Register;
   end record
      with Volatile;
   for IO_BANK_GPIO_Register use record
      STATUS at 0 range 0 .. 31;
      CTRL   at 4 range 0 .. 31;
   end record;

   type IO_BANK_GPIO_Array is array (0 .. 47) of IO_BANK_GPIO_Register
      with Component_Size => 64;

   type IO_BANK_Peripheral is record
      GPIO : IO_BANK_GPIO_Array;
   end record
      with Volatile;
   for IO_BANK_Peripheral use record
      GPIO at 0 range 0 .. 3071;
   end record;

end RP2350.IO_BANK;
