package body Test_IO is

   function readTests (filename : in String) return TTests is
      fileType : File_Type;
      tests: TTests;
   begin
      Open(File => fileType, Mode => In_File, Name => fileName);
      for i in tests'Range loop
         for j in tests(i).w'Range loop--main
            Get(fileType, tests(i).w(j));
         end loop;
         Skip_Line(fileType);

         for j in tests(i).ws'Range loop--backup
            Get(fileType, tests(i).ws(j));
         end loop;
         Skip_Line(fileType);
      end loop;
      close(fileType);
      return tests;
   end;

   procedure showTests (tests : in TTests) is
   begin
      for i in tests'Range loop
         for j in tests(i).w'Range loop--main
            Put(tests(i).w(j));
         end loop;
         New_Line;

         for j in tests(i).ws'Range loop--backup
            Put(tests(i).ws(j));
         end loop;
         New_Line;
      end loop;
   end;

begin
   null;
end;
