package body RP2350.CSR
   with SPARK_Mode => Off
is

   procedure Set_MSTATUS
      (MSTATUS : MSTATUS_Register)
   is
   begin
      System.Machine_Code.Asm
         ("csrs mstatus, %0",
          Inputs   => MSTATUS_Register'Asm_Input ("r", MSTATUS),
          Volatile => True);
   end Set_MSTATUS;

   procedure Clear_MSTATUS
      (MSTATUS : MSTATUS_Register)
   is
   begin
      System.Machine_Code.Asm
         ("csrc mstatus, %0",
          Inputs   => MSTATUS_Register'Asm_Input ("r", MSTATUS),
          Volatile => True);
   end Clear_MSTATUS;

   procedure Set_MIE
      (MIE : MIE_Register)
   is
   begin
      System.Machine_Code.Asm
         ("csrs mie, %0",
          Inputs   => MIE_Register'Asm_Input ("r", MIE),
          Volatile => True);
   end Set_MIE;

   procedure Clear_MIE
      (MIE : MIE_Register)
   is
   begin
      System.Machine_Code.Asm
         ("csrc mie, %0",
          Inputs   => MIE_Register'Asm_Input ("r", MIE),
          Volatile => True);
   end Clear_MIE;

   procedure Set_MIP
      (MIP : MIP_Register)
   is
   begin
      System.Machine_Code.Asm
         ("csrs mip, %0",
          Inputs   => MIP_Register'Asm_Input ("r", MIP),
          Volatile => True);
   end Set_MIP;

   procedure Clear_MIP
      (MIP : MIP_Register)
   is
   begin
      System.Machine_Code.Asm
         ("csrc mip, %0",
          Inputs   => MIP_Register'Asm_Input ("r", MIP),
          Volatile => True);
   end Clear_MIP;

   procedure Set_MIDELEG
      (MIDELEG : MIDELEG_Register)
   is
   begin
      System.Machine_Code.Asm
         ("csrs mideleg, %0",
          Inputs   => MIDELEG_Register'Asm_Input ("r", MIDELEG),
          Volatile => True);
   end Set_MIDELEG;

   procedure Clear_MIDELEG
      (MIDELEG : MIDELEG_Register)
   is
   begin
      System.Machine_Code.Asm
         ("csrc mideleg, %0",
          Inputs   => MIDELEG_Register'Asm_Input ("r", MIDELEG),
          Volatile => True);
   end Clear_MIDELEG;

end RP2350.CSR;
