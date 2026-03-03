package Assertions
   with SPARK_Mode => On
is
   procedure Start
      (Name : String);
   procedure Stop
      (Name : String);
   procedure Assert
      (Val : Boolean;
       Msg : String);
end Assertions;
