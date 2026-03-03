with RP2350.SysTick; use RP2350.SysTick;
with Ada.Text_IO;

package body Test_SysTick
   with SPARK_Mode => On
is
   procedure Run is
      T : Time := Time'First;
   begin
      Ada.Text_IO.Put_Line ("SysTick");
      Enable;
      Get_Clock (T);
      T := T + Milliseconds (10);
      Delay_Until (T);
      Disable;
   end Run;
end Test_SysTick;
