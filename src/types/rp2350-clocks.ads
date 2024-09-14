pragma Style_Checks ("M120");
package RP2350.CLOCKS
   with Pure, SPARK_Mode => On
is
   type Clock_Id is
      (CLK_SYS_CLOCKS,
       CLK_SYS_ACCESSCTRL,
       CLK_ADC_ADC,
       CLK_SYS_ADC,
       CLK_SYS_BOOTRAM,
       CLK_SYS_BUSCTRL,
       CLK_SYS_BUSFABRIC,
       CLK_SYS_DMA,
       CLK_SYS_GLITCH_DETECTOR,
       CLK_HSTX,
       CLK_SYS_HSTX,
       CLK_SYS_I2C0,
       CLK_SYS_I2C1,
       CLK_SYS_IO,
       CLK_SYS_JTAG,
       CLK_REF_OTP,
       CLK_SYS_OTP,
       CLK_SYS_PADS,
       CLK_SYS_PIO0,
       CLK_SYS_PIO1,
       CLK_SYS_PIO2,
       CLK_SYS_PLL_SYS,
       CLK_SYS_PLL_USB,
       CLK_REF_POWMAN,
       CLK_SYS_POWMAN,
       CLK_SYS_PWM,
       CLK_SYS_RESETS,
       CLK_SYS_ROM,
       CLK_SYS_ROSC,
       CLK_SYS_PSM,
       CLK_SYS_SHA256,
       CLK_SYS_SIO,

       CLK_PERI_SPI0,
       CLK_SYS_SPI0,
       CLK_PERI_SPI1,
       CLK_SYS_SPI1,
       CLK_SYS_SRAM0,
       CLK_SYS_SRAM1,
       CLK_SYS_SRAM2,
       CLK_SYS_SRAM3,
       CLK_SYS_SRAM4,
       CLK_SYS_SRAM5,
       CLK_SYS_SRAM6,
       CLK_SYS_SRAM7,
       CLK_SYS_SRAM8,
       CLK_SYS_SRAM9,
       CLK_SYS_SYSCFG,
       CLK_SYS_SYSINFO,
       CLK_SYS_TBMAN,
       CLK_REF_TICKS,
       CLK_SYS_TICKS,
       CLK_SYS_TIMER0,
       CLK_SYS_TIMER1,
       CLK_SYS_TRNG,
       CLK_PERI_UART0,
       CLK_SYS_UART0,
       CLK_PERI_UART1,
       CLK_SYS_UART1,
       CLK_SYS_USBCTRL,
       CLK_USB,
       CLK_SYS_WATCHDOG,
       CLK_SYS_XIP,
       CLK_SYS_XOSC);

   type Clocks0_Array is array (Clock_Id range CLK_SYS_CLOCKS .. CLK_SYS_SIO) of Boolean
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Writers,
           Async_Readers,
           Component_Size => 1,
           Object_Size => 32;

   type Clocks1_Array is array (Clock_Id range CLK_PERI_SPI0 .. CLK_SYS_XOSC) of Boolean
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Writers,
           Async_Readers,
           Component_Size => 1,
           Object_Size => 32;

   type CLOCKS_Peripheral is record
      ENABLED0    : Clocks0_Array;
      ENABLED1    : Clocks1_Array;
      WAKE_EN0    : Clocks0_Array;
      WAKE_EN1    : Clocks1_Array;
      SLEEP_EN0   : Clocks0_Array;
      SLEEP_EN1   : Clocks1_Array;
   end record
      with Volatile;
   for CLOCKS_Peripheral use record
      WAKE_EN0    at 16#AC# range 0 .. 31;
      WAKE_EN1    at 16#B0# range 0 .. 31;
      SLEEP_EN0   at 16#B4# range 0 .. 31;
      SLEEP_EN1   at 16#B8# range 0 .. 31;
      ENABLED0    at 16#BC# range 0 .. 31;
      ENABLED1    at 16#C0# range 0 .. 31;
   end record;
end RP2350.CLOCKS;
