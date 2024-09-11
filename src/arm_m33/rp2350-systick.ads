--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package RP2350.SysTick
   with Preelaborate, SPARK_Mode => On
is
   Ticks_Per_Second : constant := 100;

   type Time is mod 2 ** 32;

   procedure Get_Clock
      (T : out Time);

   function Milliseconds
      (Ms : Natural)
      return Time
   with Inline;

   procedure Delay_Until
      (T : Time);

   procedure Enable;

   procedure Disable;

end RP2350.SysTick;
