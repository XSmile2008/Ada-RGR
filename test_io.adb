package body Test_IO is

   function readTests (filename : in String) return TTests is
      fileType : File_Type;
      tests: TTests;
   begin
      Open(File => fileType, Mode => In_File, Name => fileName);
      for i in 1..100 loop
         for j in 1..20 loop--main
            Get(fileType, tests(i).w(j));
         end loop;
         Skip_Line(fileType);

         for j in 1..20 loop--backup
            Get(fileType, tests(i).ws(j));
         end loop;
         Skip_Line(fileType);
      end loop;
      close(fileType);
      return tests;
   end;

   procedure showTests (tests : in TTests) is
   begin
      for i in 1..100 loop
         for j in 1..20 loop--main
            Put(tests(i).w(j));
         end loop;
         New_Line;

         for j in 1..20 loop--backup
            Put(tests(i).ws(j));
         end loop;
         New_Line;
      end loop;
   end;

begin
   null;
end;
