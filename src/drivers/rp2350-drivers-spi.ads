with RP2350.SPI;
with RP2350.IO_BANK;
with RP2350.PADS_BANK;

generic
   Periph : in out RP2350.SPI.SPI_Peripheral;
package RP2350.Drivers.SPI
   with Preelaborate, SPARK_Mode => On
is
   procedure Initialize
      (Speed    : Positive;
       CLK_PERI : Positive);
   procedure Configure_Pin
      (IO_BANK   : in out RP2350.IO_BANK.IO_BANK_Peripheral;
       PADS_BANK : in out RP2350.PADS_BANK.PADS_BANK_Peripheral;
       Pin       : RP2350.IO_BANK.GPIO_Index);
   procedure Write
      (Data : UInt8_Array);
   procedure Read
      (Data : out UInt8_Array);
   procedure Transfer
      (TX : UInt8_Array;
       RX : out UInt8_Array)
   with Pre => TX'Length = RX'Length;
end RP2350.Drivers.SPI;
