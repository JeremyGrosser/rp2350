package Interrupts
   with Preelaborate, SPARK_Mode => On
is
   procedure IO_IRQ_BANK0_Handler
      with Export, Convention => C, External_Name => "isr_irq21";

   Triggered : Natural := 0
      with Volatile;
end Interrupts;
