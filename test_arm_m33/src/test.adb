--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
pragma Style_Checks ("M120");
pragma SPARK_Mode (On);
with Ada.Text_IO;
with RP2350.Device; use RP2350.Device;
with Test_Pins; use Test_Pins;
with Test_I2C;

procedure Test is
begin
   Ada.Text_IO.Put_Line ("Testing...");

   IO_BANK0.GPIO (LED).CTRL.FUNCSEL := 5;
   SIO.GPIO_OE_CLR (LED) := True;
   PADS_BANK0.GPIO (LED) := Output_Pad;

   Test_I2C.Run;

   Ada.Text_IO.Put_Line ("OK");

   SIO.GPIO_OUT_SET (LED) := True;
end Test;
