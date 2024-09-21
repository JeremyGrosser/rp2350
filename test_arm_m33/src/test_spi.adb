pragma Style_Checks ("M120");
with RP2350.Drivers.SPI;
with RP2350.Device;
with RP2350; use RP2350;
with RP2350.RESETS;
with Assertions;

package body Test_SPI
   with SPARK_Mode => On
is
   package SPI is new RP2350.Drivers.SPI
      (Periph => RP2350.Device.SPI0);

   SCK  : constant := 2;
   MOSI : constant := 3;
   MISO : constant := 4;

   procedure Run is
      TX : constant UInt8_Array (1 .. 4) := (1, 2, 3, 4);
      RX : UInt8_Array (1 .. 4);
   begin
      RP2350.Device.RESETS.RESET (RP2350.RESETS.SPI0) := True;
      RP2350.Device.RESETS.RESET (RP2350.RESETS.SPI0) := False;

      SPI.Initialize (Speed => 1e6, CLK_PERI => 11e6);
      SPI.Configure_Pin (RP2350.Device.IO_BANK0, RP2350.Device.PADS_BANK0, SCK);
      SPI.Configure_Pin (RP2350.Device.IO_BANK0, RP2350.Device.PADS_BANK0, MOSI);
      SPI.Configure_Pin (RP2350.Device.IO_BANK0, RP2350.Device.PADS_BANK0, MISO);

      SPI.Write (TX);
      SPI.Transfer (TX => TX, RX => RX);
      Assertions.Assert (RX = (1 .. 4 => 0),
         "SPI first read from unconnected pin was not zero");
      SPI.Read (RX);
      Assertions.Assert (RX = (1 .. 4 => 0),
         "SPI second read from unconnected pin was not zero");
   end Run;
end Test_SPI;
