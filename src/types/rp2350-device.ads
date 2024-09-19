--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP2350.SIO;
with RP2350.CLOCKS;
with RP2350.RESETS;
with RP2350.IO_BANK;
with RP2350.PADS_BANK;
with RP2350.XOSC;
with RP2350.SPI;
with RP2350.I2C;
with RP2350.WATCHDOG;
with RP2350.POWMAN;
with System;

package RP2350.Device
   with Preelaborate, SPARK_Mode => On
is
   SIO : RP2350.SIO.SIO_Peripheral
      with Import, Address => System'To_Address (16#D000_0000#);
   CLOCKS : RP2350.CLOCKS.CLOCKS_Peripheral
      with Import, Address => System'To_Address (16#4001_0000#);
   RESETS : RP2350.RESETS.RESET_Peripheral
      with Import, Address => System'To_Address (16#4002_0000#);
   IO_BANK0 : RP2350.IO_BANK.IO_BANK_Peripheral
      with Import, Address => System'To_Address (16#4002_8000#);
   PADS_BANK0 : RP2350.PADS_BANK.PADS_BANK_Peripheral
      with Import, Address => System'To_Address (16#4003_8000#);
   XOSC : RP2350.XOSC.XOSC_Peripheral
      with Import, Address => System'To_Address (16#4004_8000#);
   SPI0 : RP2350.SPI.SPI_Peripheral
      with Import, Address => System'To_Address (16#4008_0000#);
   SPI1 : RP2350.SPI.SPI_Peripheral
      with Import, Address => System'To_Address (16#4008_8000#);
   I2C0 : RP2350.I2C.I2C_Peripheral
      with Import, Address => System'To_Address (16#4009_0000#);
   I2C1 : RP2350.I2C.I2C_Peripheral
      with Import, Address => System'To_Address (16#4009_8000#);
   WATCHDOG : RP2350.WATCHDOG.WATCHDOG_Peripheral
      with Import, Address => System'To_Address (16#400D_8000#);
   POWMAN : RP2350.POWMAN.POWMAN_Peripheral
      with Import, Address => System'To_Address (16#4010_0000#);
end RP2350.Device;
