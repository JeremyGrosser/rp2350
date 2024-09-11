--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package RP2350
   with Pure, SPARK_Mode => On
is
   type UInt2 is mod 2 ** 2 with Size => 2;
   type UInt5 is mod 2 ** 5 with Size => 5;
   type UInt12 is mod 2 ** 12 with Size => 12;
   type UInt24 is mod 2 ** 24 with Size => 24;
   type UInt32 is mod 2 ** 32 with Size => 32;
   type UInt64 is mod 2 ** 64 with Size => 64;

   function Shift_Left (Item : UInt64; Amount : Natural) return UInt64
      with Import, Convention => Intrinsic;
end RP2350;
