package body Methods is

   function bruteForce(scheme : in TScheme; schemeType : in TSchemeType; tests : in TTests; plan : TPlan) return TPlan is
      maxLifeTime : Float := lifeTime(scheme, schemeType, tests, plan);
      maxPlan : TPlan := plan;
      currPlan : TPlan := plan;
      currLifeTime : Float;
   begin
      while hasNext(currPlan) loop
         currPlan := getNext(currPlan);
         if (checkBudget(scheme, currPlan)) then
            currLifeTime := lifeTime(scheme, schemeType, tests, currPlan);
            if (currLifeTime > maxLifeTime) then
               maxLifeTime := currLifeTime;
               maxPlan := currPlan;
            end if;
         end if;
      end loop;
      return maxPlan;
   end;

   function bruteForce(scheme : in TSchemeParSeq; schemeType : in TSchemeType; tests : in TTests; plan : TPlan) return TPlan is
      maxLifeTime : Float := lifeTime(scheme, schemeType, tests, plan);
      maxPlan : TPlan := plan;
      currPlan : TPlan := plan;
      currLifeTime : Float;
   begin
      while hasNext(currPlan) loop
         currPlan := getNext(currPlan);
         if (checkBudget(scheme, currPlan)) then
            currLifeTime := lifeTime(scheme, schemeType, tests, currPlan);
            if (currLifeTime > maxLifeTime) then
               maxLifeTime := currLifeTime;
               maxPlan := currPlan;
            end if;
         end if;
      end loop;
      return maxPlan;
   end;

begin
   null;
end;
