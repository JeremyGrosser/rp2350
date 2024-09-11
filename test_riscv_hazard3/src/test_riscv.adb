--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP2350.Device; use RP2350.Device;

procedure Test_RISCV is
   pragma SPARK_Mode (On);
begin
   IO_BANK0.GPIO (25).CTRL.FUNCSEL := 5;
   SIO.GPIO_OE_SET (25) := True;
   PADS_BANK0.GPIO (25).ISO := False;

   loop
      SIO.GPIO_OUT_XOR (25) := True;
   end loop;
end Test_RISCV;
