package body Methods is

   function bruteForce(scheme : in TScheme; tests : in TTests; plan : in TPlan) return TPlan is
      maxLifeTime : Float := lifeTime(scheme, tests, plan);
      maxPlan : TPlan := plan;
      currPlan : TPlan := plan;
      currLifeTime : Float;
   begin
      while hasNext(currPlan) loop
         currPlan := getNext(currPlan);
         if (checkBudget(scheme, currPlan)) then
            currLifeTime := lifeTime(scheme, tests, currPlan);
            if (currLifeTime > maxLifeTime) then
               maxLifeTime := currLifeTime;
               maxPlan := currPlan;
            end if;
         end if;
      end loop;
      return maxPlan;
   end;

   function bruteForceMultiThreaded(scheme : in TScheme; tests : in TTests; plan : in TPlan; threads : in Integer) return TPlan is

      task type bruteForceTask is
         entry Start(plan : in TPlan);
         entry Result(plan : out TPlan);
      end;

      task body bruteForceTask is
         maxPlan : TPlan;
      begin
         accept Start (plan : in TPlan) do
            maxPlan := plan;
         end Start;
         maxPlan := bruteForce(scheme, tests, maxPlan);
         accept Result (plan : out TPlan) do
            plan := maxPlan;
         end Result;
      end bruteForceTask;

      type TBruteForceTasks is array (1..threads) of bruteForceTask;
      bruteForceTasks : TBruteForceTasks;

      maxPlan : TPlan;
      maxLifeTime : Float;

   begin
      for i in bruteForceTasks'Range loop
         bruteForceTasks(i).Start(plan);
      end loop;

      for i in bruteForceTasks'Range loop
         bruteForceTasks(i).Result(newPlan);
      end loop;

      return newPlan;--TODO
   end;

begin
   null;
end;
