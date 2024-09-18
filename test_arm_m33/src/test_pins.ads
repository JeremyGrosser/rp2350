with RP2350.PADS_BANK;

package Test_Pins
   with Pure, SPARK_Mode => On
is
   LED : constant := 25;

   Output_Pad : constant RP2350.PADS_BANK.GPIO_Register :=
      (ISO        => False,
       OD         => False,
       IE         => False,
       DRIVE      => 0,
       PUE        => False,
       PDE        => True,
       SCHMITT    => True,
       SLEWFAST   => False);

end Test_Pins;
