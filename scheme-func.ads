with Plan; use Plan;

package Scheme.Func is
   function lifeTime (scheme : in TScheme; schemeType : in TSchemeType; tests : in TTests; plan : in TPlan) return Float;
   function checkBudget (scheme : in TScheme; plan : in TPlan) return Boolean;
end;
