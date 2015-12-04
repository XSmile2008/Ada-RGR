with Plan; use Plan;

package Scheme.Par_Seq.IO is
   function readScheme (filename : in String) return TSchemeParSeq;
   procedure showScheme (scheme : in TSchemeParSeq);
   procedure showLifeTime (x : in TPlan; lifeTime : Float; scheme : TSchemeParSeq);
end;
