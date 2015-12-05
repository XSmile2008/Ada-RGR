with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Test_IO; use Test_IO;
with Ada.Numerics.Generic_Elementary_Functions;

package Scheme is

   type TSchemeType is (TPar, TSeq, TPar_Seq);

   type TNode is Record
      l, ls, c : Integer;
   end record;

   type TNodeMas is array (1..20) of TNode;
   type TSchemeSizes is array (1..20) of Integer;

   type TScheme is Record
      m, c, n : Integer;
      ni : TSchemeSizes;
      nodes : TNodeMas;
   end record;
end;

