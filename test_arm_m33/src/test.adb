--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
pragma Style_Checks ("M120");
pragma SPARK_Mode (On);
with Ada.Text_IO;
with Assertions;
with RP2350.Device; use RP2350.Device;
with Test_Pins; use Test_Pins;
with Test_I2C;
with Test_SysTick;

procedure Test is
begin
   Ada.Text_IO.Put_Line ("Testing...");

   IO_BANK0.GPIO (LED).CTRL.FUNCSEL := 5;
   SIO.GPIO_OE_CLR (LED) := True;
   PADS_BANK0.GPIO (LED) := Output_Pad;

   Assertions.Start ("SysTick");
   Test_SysTick.Run;
   Assertions.Stop ("SysTick");

   Assertions.Start ("I2C");
   Test_I2C.Run;
   Assertions.Stop ("I2C");

   SIO.GPIO_OUT_SET (LED) := True;

   Ada.Text_IO.Put_Line ("DONE");
end Test;
