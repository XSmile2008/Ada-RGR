with Plan; use Plan;

package Scheme.Func is
   function lifeTime (scheme : in TScheme; tests : in TTests; plan : in TPlan) return Float;
   function checkBudget (scheme : in TScheme; plan : in TPlan) return Boolean;
   function lifeTimeParSeq (scheme : in TScheme; tests : in TTests; plan : in TPlan) return Float;
end;
