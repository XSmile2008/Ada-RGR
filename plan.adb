package body Plan is

   function hasNext(plan : in TPlan) return Boolean is
   begin
      for i in plan.fixed + 1..plan.x'Length loop
         if (plan.x(i) = 0) then return True; end if;
      end loop;
      return False;
   end;

   function getNext(plan : in TPlan) return TPlan is
      i : Integer := plan.fixed + 1;
      result : TPlan := plan;
   begin
      while (result.x(i) = 1) loop
         i := i + 1;
      end loop;
      result.x(i) := 1;
      while (i /= result.fixed + 1) loop
         i := i - 1;
         result.x(i) := 0;
      end loop;
      return result;
   end;

   function getCount(bits : in Integer) return Integer is
   begin
      return 2**bits;
   end;

   procedure showPlan(plan : in TPlan; scheme : in TScheme) is --TODO: make for ParSec
      index : Integer := 1;
   begin
      if (scheme.schemeType = TParSeq) then
         for i in 1..scheme.m loop
            for j in 1..scheme.ni(i) loop
               Put(plan.x(index));
               index := index + 1;
            end loop;
            New_Line;
         end loop;
      else
         for i in 1..scheme.m loop
            Put(plan.x(i));
         end loop;
      end if;
   end;

   function index2d1d (scheme : TScheme; index_i, index_j : Integer) return Integer is
      index : Integer := 0;
   begin
      for i in 1..index_i - 1 loop
         index := index + scheme.ni(i);
      end loop;
      return index + index_j;
   end;

begin
   null;
end;
