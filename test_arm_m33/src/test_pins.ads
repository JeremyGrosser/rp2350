with RP2350.PADS_BANK;
with RP2350.SIO;

package Test_Pins
   with Pure, SPARK_Mode => On
is
   Signal_In   : constant := 0;
   LED         : constant := 25;

   Output_Pad : constant RP2350.PADS_BANK.GPIO_Register :=
      (ISO        => False,
       OD         => False,
       IE         => False,
       DRIVE      => 0,
       PUE        => False,
       PDE        => True,
       SCHMITT    => True,
       SLEWFAST   => False);
   Input_Pad : constant RP2350.PADS_BANK.GPIO_Register :=
      (ISO        => False,   --  Isolation off
       OD         => True,    --  Output disable
       IE         => True,    --  Input enable
       DRIVE      => 0,       --  2mA drive
       PUE        => True,    --  Pull up
       PDE        => False,   --  No pull down
       SCHMITT    => True,    --  Schmitt trigger
       SLEWFAST   => False);  --  Slew control

   LED_Mask : constant RP2350.SIO.GPIO_Bit_Array :=
      (LED    => True,
       others => False);
end Test_Pins;
