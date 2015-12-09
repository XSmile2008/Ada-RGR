with Scheme; use Scheme;
with Scheme.IO; use Scheme.IO;
with Scheme.Func; use Scheme.Func;
with Test_IO; use Test_IO;
with Plan; use Plan;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;

package Methods is
   function bruteForce(scheme : in TScheme; tests : in TTests; plan : TPlan) return TPlan;
   function bruteForceMultiThreaded(scheme : in TScheme; tests : in TTests; plan : in TPlan; threads : in Integer) return TPlan;
   function branchesAndBounds(scheme : in TScheme; tests : in TTests; plan : in TPlan) return TPlan;
end;
