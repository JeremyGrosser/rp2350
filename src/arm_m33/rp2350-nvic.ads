package RP2350.NVIC
   with Pure, SPARK_Mode => On
is
   type Interrupt_Array is array (0 .. 51) of Boolean
      with Component_Size => 1;

   type NVIC_Peripheral is record
      ISER : Interrupt_Array;
      ICER : Interrupt_Array;
      ISPR : Interrupt_Array;
      ICPR : Interrupt_Array;
      IABR : Interrupt_Array;
      ITNS : Interrupt_Array;
   end record
      with Volatile,
           Effective_Writes,
           Async_Readers,
           Async_Writers;
   for NVIC_Peripheral use record
      ISER at 16#000# range 0 .. 63;
      ICER at 16#080# range 0 .. 63;
      ISPR at 16#100# range 0 .. 63;
      ICPR at 16#180# range 0 .. 63;
      IABR at 16#200# range 0 .. 63;
      ITNS at 16#280# range 0 .. 63;
   end record;
end RP2350.NVIC;
