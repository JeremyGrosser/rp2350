with Assertions; use Assertions;
with Ada.Text_IO;
with RP2350.SysTick; use RP2350.SysTick;
with RP2350.Device;
with RP2350.Drivers.I2C;
with RP2350.RESETS;
with RP2350; use RP2350;

package body Test_I2C is

   SCL : constant := 14;
   SDA : constant := 15;

   BME_Address    : constant UInt7 := 2#1110111#;
   REG_CTRL_HUM   : constant UInt8 := 16#72#;
   REG_CTRL_MEAS  : constant UInt8 := 16#74#;
   REG_ID         : constant UInt8 := 16#D0#;

   Deadline : SysTick.Time := SysTick.Time'First;

   function I2C_Time_Exceeded
      return Boolean
   is
      T : Time;
   begin
      Get_Clock (T);
      return T >= Deadline;
   end I2C_Time_Exceeded;

   package I2C is new Drivers.I2C
      (Periph        => Device.I2C1,
       Time_Exceeded => I2C_Time_Exceeded);

   procedure BME_Query
      (Speed : I2C.I2C_Speed)
   is
      Data  : UInt8_Array (1 .. 1) := (1 => REG_ID);
      Error : Boolean;
   begin
      Device.RESETS.RESET (RP2350.RESETS.I2C1) := True;
      Device.RESETS.RESET (RP2350.RESETS.I2C1) := False;
      loop
         declare
            Reset_Done : Boolean;
         begin
            Reset_Done := Device.RESETS.RESET_DONE (RP2350.RESETS.I2C1);
            exit when Reset_Done;
         end;
      end loop;

      Get_Clock (Deadline);
      Deadline := Deadline + Milliseconds (10);

      I2C.Initialize (Speed);
      I2C.Configure_Pins
         (IO_BANK    => Device.IO_BANK0,
          PADS_BANK  => Device.PADS_BANK0,
          SDA        => SDA,
          SCL        => SCL);
      I2C.Write
         (Addr  => BME_Address,
          Data  => Data,
          Error => Error,
          Stop  => False);
      Assert (Error = False, "I2C write failed");
      I2C.Read
         (Addr  => BME_Address,
          Data  => Data,
          Error => Error,
          Stop  => True);
      Assert (Error = False, "I2C read failed");
      Assert (Data (1) = 16#61#, "Incorrect BME Id");
   end BME_Query;

   procedure BME_Write is
      Error : Boolean;
   begin
      Get_Clock (Deadline);
      Deadline := Deadline + Milliseconds (10);

      I2C.Write
         (Addr  => BME_Address,
          Data  => (REG_CTRL_HUM, 1),
          Error => Error,
          Stop  => True);
      Assert (Error = False, "BME CTRL_HUM write failed");

      I2C.Write
         (Addr  => BME_Address,
          Data  => (REG_CTRL_MEAS, 2#010_101_01#),
          Error => Error,
          Stop  => True);
      Assert (Error = False, "BME CTRL_MEAS write failed");
   end BME_Write;

   procedure BME_Timeout is
      Error : Boolean;
   begin
      Deadline := Time'First;
      I2C.Write
         (Addr  => BME_Address,
          Data  => (REG_CTRL_HUM, 1),
          Error => Error,
          Stop  => True);
      Assert (Error, "I2C did not timeout after deadline");
   end BME_Timeout;

   procedure I2C_Wrong_Address is
      Error : Boolean;
   begin
      Get_Clock (Deadline);
      Deadline := Deadline + Milliseconds (10);

      I2C.Write
         (Addr  => BME_Address + 1,
          Data  => (REG_CTRL_HUM, 1),
          Error => Error,
          Stop  => True);
      Assert (Error = False, "Wrong address write did not error");
   end I2C_Wrong_Address;

   procedure Run is
   begin
      Ada.Text_IO.Put ("Test_I2C Speed Standard ");
      BME_Query (I2C.Standard);
      Ada.Text_IO.Put_Line ("OK");

      Ada.Text_IO.Put ("Test_I2C Speed Fast ");
      BME_Query (I2C.Fast);
      Ada.Text_IO.Put_Line ("OK");

      Ada.Text_IO.Put ("Test_I2C Speed High ");
      BME_Query (I2C.High);
      Ada.Text_IO.Put_Line ("OK");

      Ada.Text_IO.Put ("Test_I2C Single Write ");
      BME_Write;
      Ada.Text_IO.Put_Line ("OK");

      Ada.Text_IO.Put ("Test_I2C Timeout ");
      BME_Timeout;
      Ada.Text_IO.Put_Line ("OK");

      Ada.Text_IO.Put ("Test_I2C Wrong Address ");
      I2C_Wrong_Address;
      Ada.Text_IO.Put_Line ("OK");
   end Run;
end Test_I2C;
