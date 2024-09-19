package RP2350.SPI
   with Pure, SPARK_Mode => On
is
   type CR0_Register is record
      SCR : UInt8;
      SPH : Boolean;
      SPO : Boolean;
      FRF : UInt2;
      DSS : UInt4;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CR0_Register use record
      SCR at 0 range 8 .. 15;
      SPH at 0 range 7 .. 7;
      SPO at 0 range 6 .. 6;
      FRF at 0 range 4 .. 5;
      DSS at 0 range 0 .. 3;
   end record;

   type CR1_Register is record
      SOD : Boolean;
      MS  : Boolean;
      SSE : Boolean;
      LBM : Boolean;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CR1_Register use record
      SOD at 0 range 3 .. 3;
      MS  at 0 range 2 .. 2;
      SSE at 0 range 1 .. 1;
      LBM at 0 range 0 .. 0;
   end record;

   type CPSR_Register is record
      CPSDVSR : UInt8 := 0;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CPSR_Register use record
      CPSDVSR at 0 range 0 .. 7;
   end record;

   type SR_Register is record
      BSY : Boolean;
      RFF : Boolean;
      RNE : Boolean;
      TNF : Boolean;
      TFE : Boolean;
   end record
      with Volatile_Full_Access,
           Async_Writers,
           Object_Size => 32;
   for SR_Register use record
      BSY at 0 range 4 .. 4;
      RFF at 0 range 3 .. 3;
      RNE at 0 range 2 .. 2;
      TNF at 0 range 1 .. 1;
      TFE at 0 range 0 .. 0;
   end record;

   type SPI_Peripheral is record
      CR0  : CR0_Register;
      CR1  : CR1_Register;
      CPSR : CPSR_Register;
      DR   : UInt32;
      SR   : SR_Register;
   end record
      with Volatile;
   for SPI_Peripheral use record
      CR0   at 16#000# range 0 .. 31;
      CR1   at 16#004# range 0 .. 31;
      CPSR  at 16#010# range 0 .. 31;
      DR    at 16#008# range 0 .. 31;
      SR    at 16#00C# range 0 .. 31;
   end record;
end RP2350.SPI;
