package body Scheme_IO is

   package Float_Functions is new Ada.Numerics.Generic_Elementary_Functions (Float);
   use Float_Functions;

   function readScheme (filename : in String) return TScheme is
      fileType : File_Type;
      scheme: TScheme;
   begin
      Open(File => fileType, Mode => In_File, Name => fileName);
      Get(fileType, scheme.m);
      skip_line(fileType);
      for i in 1..scheme.m loop
         Get(fileType, scheme.nodes(i).l);
         Get(fileType, scheme.nodes(i).ls);
         Get(fileType, scheme.nodes(i).c);
         skip_line(fileType);
      end loop;
      Get(fileType, scheme.c);
      skip_line(fileType);
      Get(fileType, scheme.n);
      close(fileType);
      return scheme;
   end;

   procedure showScheme (scheme : in TScheme) is
   begin
      Put("m = ");
      Put(scheme.m);
      new_line;
      new_line;
      for i in 1..scheme.m loop
         Put(scheme.nodes(i).l);
         Put(scheme.nodes(i).ls);
         Put(scheme.nodes(i).c);
         new_line;
      end loop;
      new_line;
      Put(scheme.c);
      new_line;
      Put(scheme.n);
      new_line;
   end;

   procedure showLifeTime (x : in TRPlan; lifeTime : Float) is
   begin
      for i in 1..x'Length loop
         Put(x(i));
         New_Line;
         Put(lifeTime);
      end loop;
   end;

   function lifeTime (scheme : in TScheme; tests : in TTests; x : in TRPlan; schemeType : in TSchemeType) return Float is
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
         minORmax := t(1, k) + Float(x(1)) * tau(1, k);
         for i in 2..scheme.m loop
            txtau := t(i, k) + Float(x(1)) * tau(i, k);
            if (((txtau > minORmax) and (schemeType = TPar)) or ((txtau < minORmax) and (schemeType = TSeq))) then
               minORmax := txtau;
            end if;
         end loop;
         sum := sum + minORmax;
      end loop;
      return sum / 100.0;
   end;

   function checkBudget (scheme : in TScheme; x : in TRPlan) return Boolean is
      sum : Integer := 0;
   begin
      for i in 1..scheme.m loop
         sum := sum + scheme.nodes(i).c * x(i);
      end loop;
      return sum <= scheme.c;
   end;

begin
   null;
end;
