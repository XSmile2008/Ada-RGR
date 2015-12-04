with Plan; use Plan;

package Scheme.IO is
   function readScheme (filename : in String) return TScheme;
   procedure showScheme (scheme : in TScheme);
   procedure showLifeTime (x : in TPlan; lifeTime : in Float; scheme : in TScheme);
end;
