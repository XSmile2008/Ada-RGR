package body Scheme.Par_Seq.Func is
   package Float_Functions is new Ada.Numerics.Generic_Elementary_Functions (Float);
   use Float_Functions;

   function lifeTime (scheme : in TSchemeParSeq;  schemeType : in TSchemeType; tests : in TTests; plan : in TPlan) return Float is
      min, max, sum, txtau : Float;

      function t (i, j, k : in Integer) return Float is
      begin
         return Float(scheme.nodes(i)(j).l) * Log(1.0 / (1.0 - tests(k).w(index2d1d(scheme, i, j))));--TODO: 2d to 1d
      end;

      function tau (i, j,  k : in Integer) return Float is
      begin
         return Float(scheme.nodes(i)(j).ls) * Log(1.0 / (1.0 - tests(k).ws(index2d1d(scheme, i, j))));--TODO: 2d to 1d
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

   function checkBudget (scheme : in TSchemeParSeq; plan : in TPlan) return Boolean is
      sum : Integer := 0;
   begin
      for i in 1..scheme.m loop
         for j in 1..scheme.ni(i) loop
            sum := sum + scheme.nodes(i)(j).c * plan.x(index2d1d(scheme, i, j));
         end loop;
      end loop;
      return sum <= scheme.c;
   end;

begin
   null;
end;
