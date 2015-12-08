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

   function branchAndEdge(scheme : in TScheme; tests : in TTests; plan : in TPlan) return TPlan is

      maxPlan : TPlan := plan;
      maxLow : Float := lifeTime(scheme, tests, plan);
      maxHigh : Float := maxLow;

      function recurcive(plan : in TPlan) return TPlan is

         type TBranches is array (0..1) of TPlan;
         branches : TBranches;
         branchesCount := 1;
         tempPlan : TPlan;
         tempLifeTime : Float;
      begin
         tempPlan := plan;
         tempPlan.fixed := tempPlan.fixed + 1;
         branches := (others => tempPlan);
         branches(1).x(branches(1).fixed) := 1;

         if (checkBudget(schme, branches(1))) then
            branchesCount := branchesCount - 1;
         end loop;

         --calc low raitings
         for i in branches'Range loop
            tempLifeTime := lifeTime(scheme, tests, branches(i));
            if tempLifeTime > maxLow then
               maxLow := tempLifeTime;
            end if;
         end loop;

         --calc high raitings
         for i in branches'Range loop
            tempPlan := bruteForce(scheme, tests, branches(i));--high raiting
            tempLifeTime = lifeTime(scheme, tests, tempPlan);--high raiting
            if tempLifeTime > maxLow then
               tempPlan := recurcive(tempPlan);
               tempLifeTime := lifeTime(scheme, tests, tempPlan);
            end loop;
         end loop;

         return plan;--TODO:
      end;

   begin
      return plan;--TODO:
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
         entry start(plan : in TPlan);
      end bruteForceTask;

      task body bruteForceTask is
         maxPlan : TPlan;
      begin
         accept start (plan : in TPlan) do
            maxPlan := plan;
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
         tempPlan.fixed := Integer(Log(Float(threads), 2.0));
         temp := new bruteForceTask;
         temp.start(tempPlan);
         tempPlan.fixed := 0;
         tempPlan := getNext(tempPlan);
      end loop;
      manager.getResult(tempPlan);
      return tempPlan;
   end;

begin
   null;
end;
