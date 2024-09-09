package RP2350
   with Pure, SPARK_Mode => On
is

   type UInt2 is mod 2 ** 2 with Size => 2;
   type UInt5 is mod 2 ** 5 with Size => 5;
   type UInt32 is mod 2 ** 32 with Size => 32;

end RP2350;
