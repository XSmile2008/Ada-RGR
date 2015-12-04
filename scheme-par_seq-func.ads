with Plan; use Plan;
package Scheme.Par_Seq.Func is
   function lifeTime (scheme : in TSchemeParSeq;  schemeType : in TSchemeType; tests : in TTests; plan : in TPlan) return Float;
   function checkBudget (scheme : in TSchemeParSeq; plan : in TPlan) return Boolean;
end;
