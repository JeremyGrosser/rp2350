--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP2350.SIO;
with RP2350.IO_BANK;
with RP2350.PADS_BANK;
with RP2350.XOSC;
with RP2350.WATCHDOG;
with System;

package RP2350.Device
   with Preelaborate, SPARK_Mode => On
is
   SIO : RP2350.SIO.SIO_Peripheral
      with Import, Address => System'To_Address (16#D000_0000#);
   IO_BANK0 : RP2350.IO_BANK.IO_BANK_Peripheral
      with Import, Address => System'To_Address (16#4002_8000#);
   PADS_BANK0 : RP2350.PADS_BANK.PADS_BANK_Peripheral
      with Import, Address => System'To_Address (16#4003_8000#);
   XOSC : RP2350.XOSC.XOSC_Peripheral
      with Import, Address => System'To_Address (16#4004_8000#);
   WATCHDOG : RP2350.WATCHDOG.WATCHDOG_Peripheral
      with Import, Address => System'To_Address (16#400D_8000#);
end RP2350.Device;
