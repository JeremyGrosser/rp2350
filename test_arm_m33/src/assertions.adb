with Ada.Text_IO;

package body Assertions
   with SPARK_Mode => On
is
   Fail : Boolean := False;

   procedure Start
      (Name : String)
   is
   begin
      Ada.Text_IO.Put ("TEST ");
      Ada.Text_IO.Put (Name);
      Ada.Text_IO.New_Line;
      Fail := False;
   end Start;

   procedure Stop
      (Name : String)
   is
   begin
      if Fail then
         Ada.Text_IO.Put ("FAIL ");
      else
         Ada.Text_IO.Put ("PASS ");
      end if;
      Ada.Text_IO.Put (Name);
      Ada.Text_IO.New_Line;
   end Stop;

   procedure Assert
      (Val : Boolean;
       Msg : String)
   is
   begin
      if not Val then
         Fail := True;
         Ada.Text_IO.Put_Line ("FAIL");
         Ada.Text_IO.Put_Line (Msg);
      end if;
   end Assert;
end Assertions;
