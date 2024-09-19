--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package RP2350
   with Pure, SPARK_Mode => On
is
   type UInt2 is mod 2 ** 2 with Size => 2;
   type UInt3 is mod 2 ** 3 with Size => 3;
   type UInt4 is mod 2 ** 4 with Size => 4;
   type UInt5 is mod 2 ** 5 with Size => 5;
   type UInt7 is mod 2 ** 7 with Size => 7;
   type UInt8 is mod 2 ** 8 with Size => 8;
   type UInt10 is mod 2 ** 10 with Size => 10;
   type UInt12 is mod 2 ** 12 with Size => 12;
   type UInt16 is mod 2 ** 16 with Size => 16;
   type UInt24 is mod 2 ** 24 with Size => 24;
   type UInt32 is mod 2 ** 32 with Size => 32;
   type UInt64 is mod 2 ** 64 with Size => 64;

   type UInt8_Array is array (Natural range <>) of UInt8
      with Component_Size => 8;

   function Shift_Right (Item : UInt8; Amount : Natural) return UInt8
      with Import, Convention => Intrinsic;
   function Shift_Right (Item : UInt16; Amount : Natural) return UInt16
      with Import, Convention => Intrinsic;
   function Shift_Right (Item : UInt32; Amount : Natural) return UInt32
      with Import, Convention => Intrinsic;
   function Shift_Right (Item : UInt64; Amount : Natural) return UInt64
      with Import, Convention => Intrinsic;

   function Shift_Left (Item : UInt8; Amount : Natural) return UInt8
      with Import, Convention => Intrinsic;
   function Shift_Left (Item : UInt16; Amount : Natural) return UInt16
      with Import, Convention => Intrinsic;
   function Shift_Left (Item : UInt32; Amount : Natural) return UInt32
      with Import, Convention => Intrinsic;
   function Shift_Left (Item : UInt64; Amount : Natural) return UInt64
      with Import, Convention => Intrinsic;
end RP2350;
