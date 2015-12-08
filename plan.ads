with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Scheme; use Scheme;

package Plan is
   type TPlanX is array (1..20) of Integer range 0..1;
   type TPlanFixed is array (1..20) of Boolean;

   type TPlan is record
      x : TPlanX;
      f : TPlanFixed;
   end record;

   function hasNext(plan : in TPlan) return Boolean;
   function getNext(plan : in TPlan) return TPlan;
   function getCount(bits : in Integer) return Integer;

   procedure fixPlanVariables(plan : in out TPlan; count : in Integer);
   procedure showPlan(plan : in TPlan; scheme : in TScheme);

   function index2d1d (scheme : TScheme; index_i, index_j : Integer) return Integer;
end;
