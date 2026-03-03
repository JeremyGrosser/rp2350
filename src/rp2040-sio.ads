--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP2_Types; use RP2_Types;

package RP2040.SIO
   with Pure, SPARK_Mode => On
is
   type GPIO_Bit_Array is array (0 .. 29) of Boolean
      with Component_Size => 1,
           Size => 32,
           Volatile,
           Effective_Writes,
           Async_Writers,
           Async_Readers;

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
   for SIO_Peripheral use record
      CPUID          at 16#00# range 0 .. 31;
      GPIO_IN        at 16#04# range 0 .. 31;
      GPIO_OUT       at 16#10# range 0 .. 31;
      GPIO_OUT_SET   at 16#14# range 0 .. 31;
      GPIO_OUT_CLR   at 16#18# range 0 .. 31;
      GPIO_OUT_XOR   at 16#1C# range 0 .. 31;
      GPIO_OE        at 16#20# range 0 .. 31;
      GPIO_OE_SET    at 16#24# range 0 .. 31;
      GPIO_OE_CLR    at 16#28# range 0 .. 31;
      GPIO_OE_XOR    at 16#2C# range 0 .. 31;
   end record;
end RP2040.SIO;
