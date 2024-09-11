package Interrupts
   with Preelaborate, SPARK_Mode => On
is
   Triggered : Boolean;

   procedure Reset
      with Global => (Output => Triggered);

   function Is_Triggered
      return Boolean;

end Interrupts;
