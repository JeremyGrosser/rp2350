--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package RP2350.IO_BANK
   with Pure, SPARK_Mode => On
is
   type GPIO_STATUS_Register is record
      IRQTOPROC   : Boolean;
      INFROMPAD   : Boolean;
      OETOPAD     : Boolean;
      OUTTOPAD    : Boolean;
   end record
      with Volatile_Full_Access,
           Async_Writers,
           Object_Size => 32;
   for GPIO_STATUS_Register use record
      IRQTOPROC   at 0 range 26 .. 26;
      INFROMPAD   at 0 range 17 .. 17;
      OETOPAD     at 0 range 13 .. 13;
      OUTTOPAD    at 0 range 9 .. 9;
   end record;

   type GPIO_CTRL_Register is record
      IRQOVER     : UInt2;
      INOVER      : UInt2;
      OEOVER      : UInt2;
      OUTOVER     : UInt2;
      FUNCSEL     : UInt5 := 16#1F#;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for GPIO_CTRL_Register use record
      IRQOVER  at 0 range 28 .. 29;
      INOVER   at 0 range 16 .. 17;
      OEOVER   at 0 range 14 .. 15;
      OUTOVER  at 0 range 12 .. 13;
      FUNCSEL  at 0 range 0 .. 4;
   end record;

   type GPIO_Register is record
      STATUS : GPIO_STATUS_Register;
      CTRL   : GPIO_CTRL_Register;
   end record
      with Volatile;
   for GPIO_Register use record
      STATUS at 0 range 0 .. 31;
      CTRL   at 4 range 0 .. 31;
   end record;

   type GPIO_Index is range 0 .. 47;
   type GPIO_Array is array (GPIO_Index) of GPIO_Register
      with Component_Size => 64;

   type INT_Type is (LEVEL_LOW, LEVEL_HIGH, EDGE_LOW, EDGE_HIGH);
   for INT_Type use (0, 1, 2, 3);
   type GPIO_INT_Register is array (INT_Type) of Boolean
      with Component_Size => 1, Size => 4;

   type GPIO_INT_Array is array (0 .. 7) of GPIO_INT_Register
      with Component_Size => 4,
           Object_Size => 32,
           Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers;
   --  These MUST be divided into groups of 8*4 bits to ensure AHB writes are
   --  32 bits wide.

   type GPIO_INT_Group is array (0 .. 5) of GPIO_INT_Array
      with Component_Size => 32;

   type INT_Register is record
      INTE : GPIO_INT_Group;
      INTF : GPIO_INT_Group;
      INTS : GPIO_INT_Group;
   end record
      with Volatile,
           Size => 576;
   for INT_Register use record
      INTE at 16#00# range 0 .. 191;
      INTF at 16#18# range 0 .. 191;
      INTS at 16#30# range 0 .. 191;
   end record;

   type IO_BANK_Peripheral is record
      GPIO           : GPIO_Array;
      INTR           : GPIO_INT_Group;
      PROC0          : INT_Register;
      PROC1          : INT_Register;
      DORMANT_WAKE   : INT_Register;
   end record
      with Volatile;
   for IO_BANK_Peripheral use record
      GPIO           at 16#000# range 0 .. 3071;
      INTR           at 16#230# range 0 .. 191;
      PROC0          at 16#248# range 0 .. 575;
      PROC1          at 16#290# range 0 .. 575;
      DORMANT_WAKE   at 16#2D8# range 0 .. 575;
   end record;
end RP2350.IO_BANK;
