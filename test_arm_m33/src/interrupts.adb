with Test_Pins; use Test_Pins;
with RP2350.Device;
with RP2350.IO_BANK;
with RP2350.ARM;
with RP2350.Interrupts;

package body Interrupts is

   procedure IO_IRQ_BANK0_Handler is
   begin
      RP2350.Device.IO_BANK0.INTR (Signal_In / 6)(Signal_In mod 8)(RP2350.IO_BANK.EDGE_HIGH) := True;
      RP2350.ARM.NVIC.ICPR (RP2350.Interrupts.IO_IRQ_BANK0) := True;
      Triggered := Triggered + 1;
   end IO_IRQ_BANK0_Handler;

end Interrupts;
