--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with System.Machine_Code;

package RP2350.CSR
   with Preelaborate, SPARK_Mode => On
is
   type MSTATUS_Register is record
      SD, TSR, TW, TVM, MXR, SUM, MPRV : Boolean := False;
      XS, FS, MPP, VS : UInt2 := 0;
      SPP, MPIE, UBE, SPIE, MIE, SIE : Boolean := False;
   end record
      with Size => 32;
   for MSTATUS_Register use record
      SD    at 0 range 31 .. 31;
      TSR   at 0 range 22 .. 22;
      TW    at 0 range 21 .. 21;
      TVM   at 0 range 20 .. 20;
      MXR   at 0 range 19 .. 19;
      SUM   at 0 range 18 .. 18;
      MPRV  at 0 range 17 .. 17;
      XS    at 0 range 15 .. 16;
      FS    at 0 range 13 .. 14;
      MPP   at 0 range 11 .. 12;
      VS    at 0 range 9 .. 10;
      SPP   at 0 range 8 .. 8;
      MPIE  at 0 range 7 .. 7;
      UBE   at 0 range 6 .. 6;
      SPIE  at 0 range 5 .. 5;
      MIE   at 0 range 3 .. 3;
      SIE   at 0 range 1 .. 1;
   end record;

   type M_Register is record
      ME, SE, MT, ST, MS, SS : Boolean;
   end record
      with Object_Size => 32;
   for M_Register use record
      ME at 0 range 11 .. 11;
      SE at 0 range 9 .. 9;
      MT at 0 range 7 .. 7;
      ST at 0 range 5 .. 5;
      MS at 0 range 3 .. 3;
      SS at 0 range 1 .. 1;
   end record;

   type MIE_Register is new M_Register;
   type MIP_Register is new M_Register;
   type MIDELEG_Register is new M_Register;

   procedure Set_MSTATUS
      (MSTATUS : MSTATUS_Register)
      with Inline_Always;
   procedure Clear_MSTATUS
      (MSTATUS : MSTATUS_Register)
      with Inline_Always;

   procedure Set_MIE
      (MIE : MIE_Register)
      with Inline_Always;
   procedure Clear_MIE
      (MIE : MIE_Register)
      with Inline_Always;

   procedure Set_MIP
      (MIP : MIP_Register)
      with Inline_Always;
   procedure Clear_MIP
      (MIP : MIP_Register)
      with Inline_Always;

   procedure Set_MIDELEG
      (MIDELEG : MIDELEG_Register)
      with Inline_Always;
   procedure Clear_MIDELEG
      (MIDELEG : MIDELEG_Register)
      with Inline_Always;
end RP2350.CSR;
