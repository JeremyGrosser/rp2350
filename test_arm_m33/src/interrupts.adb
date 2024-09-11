with Test_Pins; use Test_Pins;
with RP2350.Device; use RP2350.Device;
with RP2350.IO_BANK; use RP2350.IO_BANK;
with RP2350.ARM; use RP2350.ARM;
with RP2350.Interrupts; use RP2350.Interrupts;

package body Interrupts
   with SPARK_Mode => On
is

   procedure IO_IRQ_BANK0_Handler
      with Export, Convention => C, External_Name => "isr_irq21";

   procedure IO_IRQ_BANK0_Handler is
   begin
      IO_BANK0.INTR (Signal_In / 6)(Signal_In mod 8)(EDGE_HIGH) := True;
      NVIC.ICPR (IO_IRQ_BANK0) := True;
      Triggered := True;
   end IO_IRQ_BANK0_Handler;

   function Is_Triggered
      return Boolean
   is (Triggered);

   procedure Reset is
   begin
      Triggered := False;
   end Reset;

end Interrupts;
