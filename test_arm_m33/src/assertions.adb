with Ada.Text_IO;

package body Assertions is
   procedure Assert
      (Val : Boolean;
       Msg : String)
   is
   begin
      if not Val then
         Ada.Text_IO.Put_Line ("FAIL");
         Ada.Text_IO.Put_Line (Msg);
      end if;
   end Assert;
end Assertions;
