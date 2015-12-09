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

-----------------------------------------------------------------------------------------------------------------------------------------------

   function branchesAndBounds(scheme : in TScheme; tests : in TTests; plan : in TPlan) return TPlan is

      type TBranch is record
         plan : TPlan;
         LowRating : Float;
         HighRating : Float;
      end record;

      type TBranchPtr is access TBranch;

      type TBranches is array (1..4096) of TBranchPtr;

      type TArrayList is record
         branches : TBranches;
         size : Integer;
      end record;

      list : TArrayList;

      procedure add(branch : in out TBranchPtr) is
      begin
         for i in 1..list.size loop
            if list.branches(i) = null then
               list.branches(i) := branch;
               return;
            end if;
         end loop;
         list.size := list.size + 1;
         list.branches(list.size) := branch;
      end;

      function findMaxBranch return TBranchPtr is
         maxBranch : TBranchPtr := null;
      begin
         for i in 1..list.size loop
            if list.branches(i) /= null then
               if (maxBranch /= null) then
               if list.branches(i).HighRating > maxBranch.HighRating then
                  maxBranch := list.branches(i);
                  end if;
               else
                  maxBranch := list.branches(i);
               end if;
            end if;
         end loop;
         return maxBranch;
      end;

      function findMaxLowRating return Float is
          maxLowRating : Float := 0.0;
      begin
         for i in 1..list.size loop
            if list.branches(i) /= null then
               if (maxLowRating /= 0.0) then
               if list.branches(i).LowRating > maxLowRating then
                  maxLowRating := list.branches(i).LowRating;
                  end if;
               else
                  maxLowRating := list.branches(i).LowRating;
               end if;
            end if;
         end loop;
         return maxLowRating;
      end;

      procedure expand(parent : in TBranchPtr) is
         branch0 : TBranchPtr;
         branch1 : TBranchPtr;

         procedure initBranch(branch : in out TBranchPtr) is
         begin
            branch.LowRating := lifeTime(scheme, tests, branch.plan);
            branch.HighRating := lifeTime(scheme, tests, bruteForceMultiThreaded(scheme, tests, branch.plan, 4));
         end;

      begin
         branch0 := parent;
         branch0.plan.fixed := branch0.plan.fixed + 1;
         initBranch(branch0);

         branch1 := new TBranch;
         branch1.plan := branch0.plan;
         branch1.plan.x(branch1.plan.fixed) := 1;
         if (checkBudget(scheme, branch1.plan)) then
            initBranch(branch1);
            add(branch1);
         end if;
      end;

      maxBranch : TBranchPtr;
      maxLowRating : Float := 0.0;
   begin
      list.size := 0;
      maxBranch := new TBranch;
      maxBranch.plan := plan;
      add(maxBranch);
      while maxBranch.plan.fixed /= maxBranch.plan.x'Length loop
         expand(maxBranch);
         maxBranch := findMaxBranch;
         maxLowRating := findMaxLowRating;
         New_Line;New_Line; Put("list.size = ");Put(list.size);Put(" fixed = ");Put(maxBranch.plan.fixed);Put(" LowRating = ");Put(maxLowRating);Put(" HighRating = ");Put(maxBranch.HighRating);
      end loop;
      return maxBranch.plan;
   end;

-----------------------------------------------------------------------------------------------------------------------------------------------

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
      fixed : Integer := plan.fixed + Integer(Log(Float(threads), 2.0));
   begin
      manager.init;
      for t in 1..threads loop
         tempPlan.fixed := fixed;
         temp := new bruteForceTask;
         temp.start(tempPlan);
         tempPlan.fixed := plan.fixed;
         if hasNext(tempPlan) then tempPlan := getNext(tempPlan); end if;--TODO: break
      end loop;
      manager.getResult(tempPlan);
      return tempPlan;
   end;

begin
   null;
end;
