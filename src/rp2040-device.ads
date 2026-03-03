--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with RP2040.IO_BANK0;
with RP2040.PADS_BANK0;
with RP2040.SIO;
with System;

package RP2040.Device
   with Preelaborate, SPARK_Mode => On
is
   IO_BANK0 : RP2040.IO_BANK0.IO_BANK0_Peripheral
      with Import, Address => System'To_Address (16#4001_4000#);
   PADS_BANK0 : RP2040.PADS_BANK0.PADS_BANK0_Peripheral
      with Import, Address => System'To_Address (16#4001_C000#);
   SIO : RP2040.SIO.SIO_Peripheral
      with Import, Address => System'To_Address (16#D000_0000#);
end RP2040.Device;
