with Scheme; use Scheme;
with Scheme.IO; use Scheme.IO;
with Scheme.Func; use Scheme.Func;
with Scheme.Par_Seq; use Scheme.Par_Seq;
with Scheme.Par_Seq.IO; use Scheme.Par_Seq.IO;
with Scheme.Par_Seq.Func; use Scheme.Par_Seq.Func;
with Test_IO; use Test_IO;
with Plan; use Plan;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

package Methods is
   function bruteForce(scheme : in TScheme; schemeType : in TSchemeType; tests : in TTests; plan : TPlan) return TPlan;
end;