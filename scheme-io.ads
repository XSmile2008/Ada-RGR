with Plan; use Plan;

package Scheme.IO is
   function readScheme (filename : in String; schemeType : TSchemeType) return TScheme;
   procedure showScheme (scheme : in TScheme);
   procedure showLifeTime (scheme : in TScheme; plan : in TPlan; lifeTime : in Float);
   procedure writeLifeTime (scheme : in TScheme; plan : in TPlan; lifeTime : in Float; fileName : in String);

   function readSchemeParSeq (filename : in String; schemeType : TSchemeType) return TScheme;
   procedure showSchemeParSeq (scheme : in TScheme);
end;
