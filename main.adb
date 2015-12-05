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

procedure main is
   package Float_Functions is new Ada.Numerics.Generic_Elementary_Functions (Float);
   use Float_Functions;



   procedure testIO is
      scheme : TScheme;
      tests: TTests;
   begin
      scheme := readScheme("variants/par_01.dat");
      showScheme(scheme);
      Put_Line("-----------------------------------------------");

      tests := readTests("variants/par_01.tet");
      showTests(tests);
      Put_Line("-----------------------------------------------");
   end;

   procedure testScheme is
      scheme : TScheme;
      tests: TTests;
      plan : TPlan;
      time : Float;
   begin
      plan.x := (others => 0);
      plan.b := (others => False);
      scheme := readScheme("variants/par_01.dat");
      showScheme(scheme);
      Put_Line("-----------------------------------------------");
      tests := readTests("variants/par_01.tet");
      --showTests(tests);
      --Put_Line("-----------------------------------------------");
      time := lifeTime(scheme, TPar, tests, plan);
      showLifeTime(plan, time, scheme);
      New_Line;Put_Line("-----------------------------------------------");
      plan := Methods.bruteForce(scheme, TPar, tests, plan);
      New_Line;Put_Line("-----------------------------------------------");
      showPlan(plan, scheme);
   end;

     --plan : TPlan;
begin
--     plan.x := (others => 0);
--     plan.b := (1|3|4|5 => False, others => True);
--
--     while (hasNext(plan)) loop
--        New_Line;
--        for i in 1..20 loop
--           Put(plan.x(i));
--        end loop;
--           plan := getNext(plan);
--     end loop;

   testSchemePar;
   --testSchemeParSeq;
end;
