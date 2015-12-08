package body Methods is

   package Float_Functions is new Ada.Numerics.Generic_Elementary_Functions (Float);
   use Float_Functions;

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

      protected manager is
         procedure init;
         procedure putResult(plan : in TPlan; lifeTime : in Float);
         entry getResult(plan : out TPlan);
      private
         maxPlan : TPlan;
         maxLifeTime : Float;
         activeThreads : Integer;
      end manager;

      protected body manager is
         procedure init is
         begin
            activeThreads := threads;
         end;

         procedure putResult(plan : in TPlan; lifeTime : in Float) is
         begin
            New_Line; showLifeTime(scheme, plan, lifeTime);
            if lifeTime > maxLifeTime then
               maxPlan := plan;
               maxLifeTime := lifeTime;
            end if;
            activeThreads := activeThreads - 1;
         end;

         entry getResult(plan : out TPlan) when activeThreads = 0 is
         begin
            plan := maxPlan;
         end;
      end manager;

      task type bruteForceTask is
         entry start(plan : in TPlan; fixed : in Integer);
      end bruteForceTask;

      task body bruteForceTask is
         maxPlan : TPlan;
      begin
         accept start (plan : in TPlan; fixed : in Integer) do
            maxPlan := plan;
            fixPlanVariables(maxPlan, fixed);
         end start;
         maxPlan := bruteForce(scheme, tests, maxPlan);
         manager.putResult(maxPlan, lifeTime(scheme, tests, maxPlan));
      end bruteForceTask;


      type bruteForceTaskPtr is access bruteForceTask;
      temp : bruteForceTaskPtr;
      tempPlan : TPlan := plan;
   begin
      manager.init;
      for t in 1..threads loop
         temp := new bruteForceTask;
         temp.start(tempPlan, Integer(Log(Float(threads), 2.0)));
         tempPlan := getNext(tempPlan);
      end loop;
      manager.getResult(tempPlan);
      return tempPlan;
   end;

begin
   null;
end;
