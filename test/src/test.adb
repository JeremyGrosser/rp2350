with RP2350.Device; use RP2350.Device;
with RP2350.SysTick;

procedure Test is
   pragma SPARK_Mode (On);
   package Timer renames RP2350.SysTick;
   use type Timer.Time;

   T : Timer.Time;
begin
   IO_BANK0.GPIO (25).CTRL.FUNCSEL := 5;

   Timer.Enable;
   Timer.Get_Clock (T);
   loop
      SIO.GPIO_OUT_XOR (25) := True;
      T := T + Timer.Milliseconds (100);
      Timer.Delay_Until (T);
   end loop;
end Test;
