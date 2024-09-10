with RP2350.Device; use RP2350.Device;
with RP2350.XOSC;
with RP2350.SysTick;

procedure Test is
   pragma SPARK_Mode (On);
   package Timer renames RP2350.SysTick;
   use type Timer.Time;
   T : Timer.Time;
   Stable : Boolean;
begin
   XOSC.CTRL :=
      (ENABLE     => RP2350.XOSC.ENABLE_KEY,
       FREQ_RANGE => RP2350.XOSC.FREQ_1_15);

   for I in 1 .. 120_000 loop
      Stable := XOSC.STATUS.STABLE;
      exit when Stable;
   end loop;

   if not Stable then
      WATCHDOG.CTRL.TRIGGER := True;
   end if;

   IO_BANK0.GPIO (25).CTRL.FUNCSEL := 5;
   SIO.GPIO_OE_SET (25) := True;
   PADS_BANK0.GPIO (25).ISO := False;

   Timer.Enable;
   Timer.Get_Clock (T);
   loop
      SIO.GPIO_OUT_XOR (25) := True;
      T := T + Timer.Milliseconds (2000);
      Timer.Delay_Until (T);
   end loop;
end Test;
