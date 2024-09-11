with RP2350.ARM;
with RP2350.Interrupts;

package body Interrupts is

   procedure IO_IRQ_BANK0_Handler is
   begin
      Triggered := Triggered + 1;
      RP2350.ARM.NVIC.ICPR0 (RP2350.Interrupts.IO_IRQ_BANK0) := True;
   end IO_IRQ_BANK0_Handler;

end Interrupts;
