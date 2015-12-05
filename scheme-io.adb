package body Scheme.IO is

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

   --TODO: to File
   procedure showLifeTime (x : in TPlan; lifeTime : in Float; scheme : in TScheme) is
   begin
      showPlan(x, scheme);
      New_Line;
      Put(lifeTime);
   end;

-----------------------------------------------------------------------ParSec------------------------------------------

   function readSchemeParSec (filename : in String) return TScheme is
      fileType : File_Type;
      scheme : TScheme;
      index : Integer := 1;
   begin
      Open(File => fileType, Mode => In_File, Name => fileName);
      Get(fileType, scheme.m);
      skip_line(fileType);
      for i in 1..scheme.m loop
         Get(fileType, scheme.ni(i));
         skip_line(fileType);
         for j in 1..scheme.ni(i) loop
            Get(fileType, scheme.nodes(index).l);
            Get(fileType, scheme.nodes(index).ls);
            Get(fileType, scheme.nodes(index).c);
            index := index + 1;
            skip_line(fileType);
         end loop;
      end loop;
      Get(fileType, scheme.c);
      skip_line(fileType);
      Get(fileType, scheme.n);
      close(fileType);
      return scheme;
   end;

   procedure showSchemeParSec (scheme : in TScheme) is
      index : Integer := 1;
   begin
      Put("m = ");
      Put(scheme.m);
      new_line;
      new_line;
      for i in 1..scheme.m loop
         Put("ni = "); Put(scheme.ni(i));
         new_line;
         for j in 1..scheme.ni(i) loop
            Put(scheme.nodes(index).l);
            Put(scheme.nodes(index).ls);
            Put(scheme.nodes(index).c);
            index := index + 1;
            new_line;
         end loop;
      end loop;
      new_line;
      Put(scheme.c);
      new_line;
      Put(scheme.n);
      new_line;
   end;

begin
   null;
end;
