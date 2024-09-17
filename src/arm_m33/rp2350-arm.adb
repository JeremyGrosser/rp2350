with System.Machine_Code;

package body RP2350.ARM
   with SPARK_Mode => Off
is
   procedure Wait_For_Interrupt is
   begin
      System.Machine_Code.Asm ("dsb", Volatile => True);
      System.Machine_Code.Asm ("isb", Volatile => True);
      System.Machine_Code.Asm ("wfi", Volatile => True);
   end Wait_For_Interrupt;
end RP2350.ARM;
