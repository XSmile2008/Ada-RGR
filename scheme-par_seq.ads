package Scheme.Par_Seq is

   type TNodeMasMas is array (1..100) of TNodeMas;
   type TSchemeSizes is array (1..100) of Integer;

   type TSchemeParSeq is Record
      m, c, n : Integer;
      ni : TSchemeSizes;
      nodes : TNodeMasMas;
   end record;

end Scheme.Par_Seq;
