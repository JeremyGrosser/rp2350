--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package RP2350.PADS_BANK
   with Pure, SPARK_Mode => On
is

   type GPIO_Register is record
      ISO      : Boolean := True;
      OD       : Boolean := False;
      IE       : Boolean := False;
      DRIVE    : UInt2 := 2#01#;
      PUE      : Boolean := False;
      PDE      : Boolean := True;
      SCHMITT  : Boolean := True;
      SLEWFAST : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for GPIO_Register use record
      ISO      at 0 range 8 .. 8;
      OD       at 0 range 7 .. 7;
      IE       at 0 range 6 .. 6;
      DRIVE    at 0 range 4 .. 5;
      PUE      at 0 range 3 .. 3;
      PDE      at 0 range 2 .. 2;
      SCHMITT  at 0 range 1 .. 1;
      SLEWFAST at 0 range 0 .. 0;
   end record;

   type PADS_BANK_GPIO_Array is array (0 .. 47) of GPIO_Register
      with Component_Size => 32;

   type PADS_BANK_Peripheral is record
      VOLTAGE_SELECT : UInt32;
      GPIO           : PADS_BANK_GPIO_Array;
      SWCLK          : GPIO_Register;
      SWD            : GPIO_Register;
   end record
      with Volatile;
   for PADS_BANK_Peripheral use record
      VOLTAGE_SELECT at 16#00# range 0 .. 31;
      GPIO           at 16#04# range 0 .. 1535;
      SWCLK          at 16#C4# range 0 .. 31;
      SWD            at 16#C8# range 0 .. 31;
   end record;

end RP2350.PADS_BANK;
