--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
pragma Style_Checks ("M120");
pragma SPARK_Mode (On);
with RP2350.Device; use RP2350.Device;
with RP2350.ARM; use RP2350.ARM;
with RP2350.IO_BANK;
with RP2350.SysTick;
with RP2350.Interrupts;
with Interrupts;
with Test_Pins; use Test_Pins;
with Ada.Text_IO;

with Test_I2C;

procedure Test is
   package Timer renames RP2350.SysTick;
   use type Timer.Time;
   T : Timer.Time;
begin
   Ada.Text_IO.Put_Line ("Testing...");

   IO_BANK0.GPIO (LED).CTRL.FUNCSEL := 5;
   IO_BANK0.GPIO (Signal_In).CTRL.FUNCSEL := 5;

   SIO.GPIO_OE_SET (LED) := True;
   SIO.GPIO_OE_CLR (Signal_In) := True;

   PADS_BANK0.GPIO (LED) := Output_Pad;
   PADS_BANK0.GPIO (Signal_In) := Input_Pad;

   IO_BANK0.PROC0.INTE (Signal_In / 6)(Signal_In mod 8)(RP2350.IO_BANK.EDGE_HIGH) := True;
   NVIC.ICPR (RP2350.Interrupts.IO_IRQ_BANK0) := True;
   Interrupts.Reset;
   NVIC.ISER (RP2350.Interrupts.IO_IRQ_BANK0) := True;

   Timer.Enable;

   Test_I2C.Run;

   Timer.Get_Clock (T);
   SIO.GPIO_OUT_XOR := LED_Mask;
   T := T + Timer.Milliseconds (10);
   Timer.Delay_Until (T);
   SIO.GPIO_OUT_XOR := LED_Mask;
   Timer.Disable;

   Ada.Text_IO.Put_Line ("OK");
end Test;
