package RP2350.SIO is

   type GPIO_Bit_Array is array (0 .. 47) of Boolean
      with Component_Size => 1, Size => 64;

   type SIO_Peripheral is record
      CPUID          : UInt32;
      GPIO_IN        : GPIO_Bit_Array;
      GPIO_OUT       : GPIO_Bit_Array;
      GPIO_OUT_SET   : GPIO_Bit_Array;
      GPIO_OUT_CLR   : GPIO_Bit_Array;
      GPIO_OUT_XOR   : GPIO_Bit_Array;
      GPIO_OE        : GPIO_Bit_Array;
      GPIO_OE_SET    : GPIO_Bit_Array;
      GPIO_OE_CLR    : GPIO_Bit_Array;
      GPIO_OE_XOR    : GPIO_Bit_Array;
   end record
      with Volatile,
           Effective_Writes,
           Async_Readers,
           Async_Writers;

end RP2350.SIO;
