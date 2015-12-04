package body Plan is

   function hasNext(Plan : in TPlan) return Boolean is
   begin
      for i in 1..20 loop
         if (plan.x(i) = 0 and plan.b(i) = False) then return True; end if;
      end loop;
      return False;
   end;

   function getNext(plan : in TPlan) return TPlan is
      i : Integer := 1;
      result : TPlan := plan;
   begin
      while (result.x(i) = 1 or result.b(i) = True) loop
         i := i + 1;
      end loop;
      result.x(i) := 1;
      while (i /= 1) loop
         i := i - 1;
         if (result.b(i) = False) then
            result.x(i) := 0;
         end if;
      end loop;
      return result;
   end;

   function getCount(bits : in Integer) return Integer is
   begin
      return 2**bits;
   end;

   procedure showPlan(plan : in TPlan; scheme : in TScheme) is
   begin
      for i in 1..scheme.m loop
         Put(plan.x(i));
      end loop;
   end;

   procedure showPlan(plan : in TPlan; scheme : in TSchemeParSeq) is
      temp : Integer := 0;
   begin
      for i in 1..scheme.m loop
         temp := temp + scheme.ni(i);
         for j in 1..scheme.ni(i) loop
            Put(plan.x(temp + j));
         end loop;
         New_Line;
      end loop;
   end;

   function index2d1d (scheme : TSchemeParSeq; index_i, index_j : Integer) return Integer is
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