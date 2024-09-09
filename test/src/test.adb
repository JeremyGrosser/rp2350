with RP2350.IO_BANK;
with RP2350.SIO;
with System;

procedure Test is
   SIO : RP2350.SIO.SIO_Peripheral
      with Import, Address => System'To_Address (16#D000_0000#);
   IO_BANK0 : RP2350.IO_BANK.IO_BANK_Peripheral
      with Import, Address => System'To_Address (16#4002_8000#);
begin
   IO_BANK0.GPIO (25).CTRL.FUNCSEL := 5;
   loop
      SIO.GPIO_OUT_XOR (25) := True;
   end loop;
end Test;
