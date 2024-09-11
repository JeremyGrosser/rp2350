package RP2350.NVIC
   with Pure, SPARK_Mode => On
is
   type Interrupt_Array is array (0 .. 31) of Boolean
      with Component_Size => 1;

   type NVIC_Peripheral is record
      ISER0 : Interrupt_Array;
      ICER0 : Interrupt_Array;
      ISPR0 : Interrupt_Array;
      ICPR0 : Interrupt_Array;
      ISER1 : Interrupt_Array;
      ICER1 : Interrupt_Array;
      ISPR1 : Interrupt_Array;
      ICPR1 : Interrupt_Array;
   end record
      with Volatile,
           Effective_Writes,
           Async_Readers,
           Async_Writers;
   for NVIC_Peripheral use record
      ISER0 at 16#000# range 0 .. 31;
      ICER0 at 16#180# range 0 .. 31;
      ISPR0 at 16#200# range 0 .. 31;
      ICPR0 at 16#280# range 0 .. 31;
      ISER1 at 16#104# range 0 .. 31;
      ICER1 at 16#184# range 0 .. 31;
      ISPR1 at 16#204# range 0 .. 31;
      ICPR1 at 16#284# range 0 .. 31;
   end record;
end RP2350.NVIC;
