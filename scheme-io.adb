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

begin
   null;
end;
