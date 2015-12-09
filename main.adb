with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;
with Scheme; use Scheme;
with Scheme.IO; use Scheme.IO;
with Scheme.Func; use Scheme.Func;
with Test_IO; use Test_IO;
with Plan; use Plan;
with Methods; use Methods;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure main is
   package Float_Functions is new Ada.Numerics.Generic_Elementary_Functions (Float);
   use Float_Functions;

   schemeType : TSchemeType := TPar;
   schemeTypeString : Unbounded_String;
   path : String := "variants/";
   variant : String := "01";

   procedure testScheme is
      scheme : TScheme;
      tests: TTests;
      plan : TPlan;
      time : Float;
   begin
      plan.x := (others => 0);
      plan.fixed := 10;--TODO: block unused for this size of scheme

      scheme := readScheme(path & To_String(schemeTypeString) & "_" & variant & ".dat", schemeType);
      tests := readTests(path & To_String(schemeTypeString) & "_" & variant & ".tet");
      showScheme(scheme);Put_Line("-----------------------------------------------");
      --showTests(tests);Put_Line("-----------------------------------------------");

      time := lifeTime(scheme, tests, plan);
      showLifeTime( scheme, plan, time);
      New_Line;Put_Line("-----------------------------------------------");

      --plan := Methods.bruteForce(scheme, tests, plan);
      --plan := Methods.branchesAndBounds(scheme, tests, plan);
      plan := Methods.multiThreaded(scheme, tests, plan, TBruteForce, 4);
      New_Line;Put_Line("-----------------------------------------------");
      showLifeTime(scheme, plan, lifeTime(scheme, tests, plan));
      writeLifeTime(scheme, plan, lifeTime(scheme, tests, plan), path & "out.txt");
   end;

   procedure testPlan is
      plan : TPlan;
      scheme : TScheme;
   begin
      scheme.schemeType := TPar;
      scheme.m := 20;
      plan.x := (others => 0);
      plan.fixed := 12;
      for i in 1..16 loop
         New_Line;showLifeTime(scheme, plan, 0.0);
         plan := getNext(plan);
      end loop;
   end;

begin
   if (schemeType = TPar) then schemeTypeString := To_Unbounded_String("par");
   elsif (schemeType = TSeq) then schemeTypeString := To_Unbounded_String("seq");
   else schemeTypeString := To_Unbounded_String("par_seq"); end if;
   testScheme;
   --testPlan;
end;
