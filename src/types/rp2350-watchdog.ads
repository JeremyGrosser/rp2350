--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package RP2350.WATCHDOG
   with Pure, SPARK_Mode => On
is
   type CTRL_Register is record
      TRIGGER     : Boolean;
      ENABLE      : Boolean;
      PAUSE_DBG1  : Boolean;
      PAUSE_DBG0  : Boolean;
      PAUSE_JTAG  : Boolean;
      TIME        : UInt24;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for CTRL_Register use record
      TRIGGER     at 0 range 31 .. 31;
      ENABLE      at 0 range 30 .. 30;
      PAUSE_DBG1  at 0 range 26 .. 26;
      PAUSE_DBG0  at 0 range 25 .. 25;
      PAUSE_JTAG  at 0 range 24 .. 24;
      TIME        at 0 range 0 .. 23;
   end record;

   type WATCHDOG_Peripheral is record
      CTRL : CTRL_Register;
   end record
      with Volatile;
   for WATCHDOG_Peripheral use record
      CTRL at 16#00# range 0 .. 31;
   end record;
end RP2350.WATCHDOG;
