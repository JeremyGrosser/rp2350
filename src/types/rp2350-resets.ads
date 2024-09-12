package RP2350.RESETS
   with Pure, SPARK_Mode => On
is
   type Reset_Id is
      (ADC, BUSCTRL, DMA, HSTX, I2C0, I2C1, IO_BANK0, IO_QSPI, JTAG,
       PADS_BANK0, PADS_QSPI, PIO0, PIO1, PIO2, PLL_SYS, PLL_USB, PWM, SHA256,
       SPI0, SPI1, SYSCFG, SYSINFO, TBMAN, TIMER0, TIMER1, TRNG, UART0, UART1,
       USBCTRL)
   with Size => 32;

   type RESET_Array is array (Reset_Id) of Boolean
      with Component_Size => 1,
           Size => 32,
           Volatile_Full_Access,
           Effective_Writes,
           Async_Writers,
           Async_Readers;

   type RESET_Peripheral is record
      RESET, WDSEL, RESET_DONE : RESET_Array;
   end record
      with Volatile;
   for RESET_Peripheral use record
      RESET      at 0 range 0 .. 31;
      WDSEL      at 4 range 0 .. 31;
      RESET_DONE at 8 range 0 .. 31;
   end record;
end RP2350.RESETS;
