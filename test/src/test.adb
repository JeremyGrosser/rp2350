with RP2350.Device; use RP2350.Device;
with RP2350.SysTick; use RP2350.SysTick;

procedure Test is
   pragma SPARK_Mode (On);
   T : Time;
begin
   IO_BANK0.GPIO (25).CTRL.FUNCSEL := 5;

   RP2350.SysTick.Enable;
   Get_Clock (T);
   loop
      SIO.GPIO_OUT_XOR (25) := True;
      T := T + Milliseconds (100);
      Delay_Until (T);
   end loop;
end Test;
