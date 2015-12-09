package body Scheme.IO is

   function readScheme (filename : in String; schemeType : TSchemeType) return TScheme is
      fileType : File_Type;
      scheme: TScheme;
   begin
      if (schemeType = TParSeq) then return readSchemeParSeq(filename, schemeType); end if;
      scheme.schemeType := schemeType;
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
      if (scheme.schemeType = TParSeq) then showSchemeParSeq(scheme);
      else
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
      end if;
   end;

   procedure showLifeTime (scheme : in TScheme; plan : in TPlan; lifeTime : in Float) is
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
      New_Line;
      Put(lifeTime);
   end;

   procedure writeLifeTime (scheme : in TScheme; plan : in TPlan; lifeTime : in Float; fileName : in String) is
      fileType : File_Type;
      index : Integer := 1;
   begin
      Open(File => fileType, Mode => Out_File, Name => fileName);
      if (scheme.schemeType = TParSeq) then
         for i in 1..scheme.m loop
            for j in 1..scheme.ni(i) loop
               Put(fileType, plan.x(index));
               index := index + 1;
            end loop;
            New_Line(fileType);
         end loop;
      else
         for i in 1..scheme.m loop
            Put(fileType, plan.x(i));
         end loop;
      end if;
      New_Line;
      Put(fileType, lifeTime);
      Close(fileType);
   end;

   -----------------------------------------------------------------------ParSec------------------------------------------

   function readSchemeParSeq (filename : in String; schemeType : TSchemeType) return TScheme is
      fileType : File_Type;
      scheme : TScheme;
      index : Integer := 1;
   begin
      scheme.schemeType := schemeType;
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

   procedure showSchemeParSeq (scheme : in TScheme) is
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
