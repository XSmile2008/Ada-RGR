package body Scheme.Func is
   package Float_Functions is new Ada.Numerics.Generic_Elementary_Functions (Float);
   use Float_Functions;

   function lifeTime (scheme : in TScheme; schemeType : in TSchemeType; tests : in TTests; plan : in TPlan) return Float is
      minORmax, sum, txtau : Float;

      function t (i, k : in Integer) return Float is
      begin
         return Float(scheme.nodes(i).l) * Log(1.0 / (1.0 - tests(k).w(i)));
      end;

      function tau (i, k : in Integer) return Float is
      begin
         return Float(scheme.nodes(i).ls) * Log(1.0 / (1.0 - tests(k).ws(i)));
      end;

   begin
      sum := 0.0;
      for k in 1..tests'Length loop
         minORmax := t(1, k) + Float(plan.x(1)) * tau(1, k);
         for i in 2..scheme.m loop
            txtau := t(i, k) + Float(plan.x(i)) * tau(i, k);
            if (((txtau > minORmax) and (schemeType = TPar)) or ((txtau < minORmax) and (schemeType = TSeq))) then
               minORmax := txtau;
            end if;
         end loop;
         sum := sum + minORmax;
      end loop;
      return sum / 100.0;
   end;

   function checkBudget (scheme : in TScheme; plan : in TPlan) return Boolean is
      sum : Integer := 0;
   begin
      for i in 1..scheme.m loop
         sum := sum + scheme.nodes(i).c * plan.x(i);
      end loop;
      return sum <= scheme.c;
   end;
begin
   null;
end;
