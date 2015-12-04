package body Scheme.Par_Seq.IO is
   function readScheme (filename : in String) return TSchemeParSeq is
      fileType : File_Type;
      scheme : TSchemeParSeq;
   begin
      Open(File => fileType, Mode => In_File, Name => fileName);
      Get(fileType, scheme.m);
      skip_line(fileType);
      for i in 1..scheme.m loop
         Get(fileType, scheme.ni(i));
         skip_line(fileType);
         for j in 1..scheme.ni(i) loop
            Get(fileType, scheme.nodes(i)(j).l);
            Get(fileType, scheme.nodes(i)(j).ls);
            Get(fileType, scheme.nodes(i)(j).c);
            skip_line(fileType);
         end loop;
      end loop;
      Get(fileType, scheme.c);
      skip_line(fileType);
      Get(fileType, scheme.n);
      close(fileType);
      return scheme;
   end;

   procedure showScheme (scheme : in TSchemeParSeq) is
   begin
      Put("m = ");
      Put(scheme.m);
      new_line;
      new_line;
      for i in 1..scheme.m loop
         Put("ni = "); Put(scheme.ni(i));
         new_line;
         for j in 1..scheme.ni(i) loop
            Put(scheme.nodes(i)(j).l);
            Put(scheme.nodes(i)(j).ls);
            Put(scheme.nodes(i)(j).c);
            new_line;
         end loop;
      end loop;
      new_line;
      Put(scheme.c);
      new_line;
      Put(scheme.n);
      new_line;
   end;

   procedure showLifeTime (x : in TPlan; lifeTime : Float; scheme : TSchemeParSeq) is
   begin
      showPlan(x, scheme);
      Put(lifeTime);
   end;

begin
   null;
end;
