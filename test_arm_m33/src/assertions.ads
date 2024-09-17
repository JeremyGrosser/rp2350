package Assertions
   with SPARK_Mode => On
is
   procedure Assert
      (Val : Boolean;
       Msg : String);
end Assertions;
