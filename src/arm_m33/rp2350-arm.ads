with RP2350.NVIC;
with System;

package RP2350.ARM
   with Preelaborate, SPARK_Mode => On
is
   procedure Wait_For_Interrupt
      with Inline_Always;

   NVIC : RP2350.NVIC.NVIC_Peripheral
      with Import, Address => System'To_Address (16#E000_E100#);
end RP2350.ARM;
