with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

package Test_IO is

   type TTestMas is array (1..20) of Float;

   type TTest is record
      w : TTestMas;
      ws : TTestMas;
   end record;

   type TTests is array (1..100) of TTest;

   function readTests (filename : in String) return TTests;
   procedure showTests (tests : in TTests);
end;
