package body Scheme.Func is
   package Float_Functions is new Ada.Numerics.Generic_Elementary_Functions (Float);
   use Float_Functions;

   function lifeTime (scheme : in TScheme; tests : in TTests; plan : in TPlan) return Float is
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
      if (scheme.schemeType = TParSeq) then return lifeTimeParSeq(scheme, tests, plan); end if;
      sum := 0.0;
      for k in 1..tests'Length loop
         minORmax := t(1, k) + Float(plan.x(1)) * tau(1, k);
         for i in 2..scheme.m loop
            txtau := t(i, k) + Float(plan.x(i)) * tau(i, k);
            if (((txtau > minORmax) and (scheme.schemeType = TPar)) or ((txtau < minORmax) and (scheme.schemeType = TSeq))) then
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
      if (scheme.schemeType = TParSeq) then return checkBudgetParSeq(scheme, plan); end if;
      for i in 1..scheme.m loop
         sum := sum + scheme.nodes(i).c * plan.x(i);
      end loop;
      return sum <= scheme.c;
   end;

------------------------------------------------------------------ParSec----------------------------------------------------------------

   function lifeTimeParSeq (scheme : in TScheme; tests : in TTests; plan : in TPlan) return Float is
      min, max, sum, txtau : Float;

      function t (i, j, k : in Integer) return Float is
      begin
         return Float(scheme.nodes(index2d1d(scheme, i, j)).l) * Log(1.0 / (1.0 - tests(k).w(index2d1d(scheme, i, j))));--TODO: 2d to 1d
      end;

      function tau (i, j,  k : in Integer) return Float is
      begin
         return Float(scheme.nodes(index2d1d(scheme, i, j)).ls) * Log(1.0 / (1.0 - tests(k).ws(index2d1d(scheme, i, j))));--TODO: 2d to 1d
      end;

   begin
      sum := 0.0;
      for k in 1..100 loop
         max := 0.0;
         for i in 1..scheme.m loop
            min := 0.0;
            for j in 1..scheme.ni(i) loop
               txtau := t(i,j,k) + Float(plan.x(index2d1d(scheme, i, j))) * tau(i, j, k);
               if (txtau < min) then min := txtau; end if;
            end loop;
            if (min > max) then max := min; end if;
         end loop;
         sum := sum + max;
      end loop;
      return sum;
   end;

   function checkBudgetParSeq (scheme : in TScheme; plan : in TPlan) return Boolean is
      sum : Integer := 0;
   begin
      for i in 1..scheme.m loop
         for j in 1..scheme.ni(i) loop
            sum := sum + scheme.nodes(index2d1d(scheme, i, j)).c * plan.x(index2d1d(scheme, i, j));
         end loop;
      end loop;
      return sum <= scheme.c;
   end;

begin
   null;
end;
