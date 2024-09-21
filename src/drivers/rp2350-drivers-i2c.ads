with RP2350.I2C;
with RP2350.PADS_BANK;
with RP2350.IO_BANK;

generic
   Periph : in out RP2350.I2C.I2C_Peripheral;
   with procedure Get_Timeout (Timeout : out Boolean);
package RP2350.Drivers.I2C
   with Preelaborate, SPARK_Mode => On
is
   type I2C_Speed is
      (Standard,
       Fast,
       High);
   for I2C_Speed use
      (Standard => 100_000,
       Fast     => 400_000,
       High     => 1_000_000);

   type CLK_SYS_Frequency is range 1e6 .. 300e6;

   procedure Initialize
      (Speed   : I2C_Speed := Standard;
       CLK_SYS : CLK_SYS_Frequency := 11e6);

   procedure Configure_Pins
      (IO_BANK   : in out RP2350.IO_BANK.IO_BANK_Peripheral;
       PADS_BANK : in out RP2350.PADS_BANK.PADS_BANK_Peripheral;
       SDA       : RP2350.IO_BANK.GPIO_Index;
       SCL       : RP2350.IO_BANK.GPIO_Index);

   procedure Write
      (Addr  : UInt7;
       Data  : UInt8_Array;
       Error : out Boolean;
       Stop  : Boolean := True);

   procedure Read
      (Addr  : UInt7;
       Data  : out UInt8_Array;
       Error : out Boolean;
       Stop  : Boolean := True);
end RP2350.Drivers.I2C;
