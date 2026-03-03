with Ada.Real_Time; use Ada.Real_Time;
with RP2040.Device; use RP2040.Device;
with RP2040.PADS_BANK0;
with RP2040.SIO;

procedure Test_Rp2040 is
   LED         : constant := 25;
   LED_Mask    : constant RP2040.SIO.GPIO_Bit_Array :=
      (LED     => True,
       others  => False);
   Output_Pad  : constant RP2040.PADS_BANK0.GPIO_Register :=
      (OD         => False,
       IE         => False,
       DRIVE      => 1,
       PUE        => False,
       PDE        => True,
       SCHMITT    => True,
       SLEWFAST   => False);

   T : Time := Clock;
begin
   IO_BANK0.GPIO (LED).CTRL.FUNCSEL := 5;
   PADS_BANK0.GPIO (LED) := Output_Pad;

   SIO.GPIO_OUT_SET := LED_Mask;
   SIO.GPIO_OE_SET := LED_Mask;
   loop
      SIO.GPIO_OE_XOR := LED_Mask;
      T := T + Milliseconds (250);
      delay until T;
   end loop;
end Test_Rp2040;
