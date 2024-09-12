--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
pragma Style_Checks ("M120");
with RP2350.Device; use RP2350.Device;
with RP2350; use RP2350;
with RP2350.CSR;

procedure Test_RISCV is
   pragma SPARK_Mode (On);
begin
   IO_BANK0.GPIO (25).CTRL.FUNCSEL := 5;
   SIO.GPIO_OE_SET (25) := True;
   PADS_BANK0.GPIO (25).ISO := False;

   --  https://danielmangum.com/posts/risc-v-bytes-timer-interrupts/#enabling-timer-interrupts

   --  Enable global machine and supervisor interrupts
   RP2350.CSR.Set_MSTATUS
      ((MIE => True, SIE => True, others => <>));

   --  Enable timer interrupts
   RP2350.CSR.Set_MIE
      ((MT => True, ST => True, others => <>));

   --  Delegate supervisor timer interrupts to supervisor mode
   RP2350.CSR.Set_MIDELEG
      ((ST => True, others => <>));

   loop
      SIO.GPIO_OUT_XOR (25) := True;
   end loop;
end Test_RISCV;
