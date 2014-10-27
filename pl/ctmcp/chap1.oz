declare Pascal FastPascal ShiftLeft ShiftRight AddList
fun {Pascal N}
   if N == 1 then [1]
   else
      {AddList {ShiftLeft {Pascal N-1}}
               {ShiftRight {Pascal N-1}}}
   end
end

fun {FastPascal N}
   if N==1 then [1]
   else L in
      L={FastPascal N-1}
      {AddList {ShiftLeft L} {ShiftRight L}}
   end
end

fun {ShiftLeft L}
   case L of
      H|T then H|{ShiftLeft T}
   else
      [0]
   end
end

fun {ShiftRight L}
   0|L
end

fun {AddList L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 H1 + H2 | {AddList T1 T2}
      else
	 nil			% added by me
      end
   else
      nil
   end
end

declare
fun lazy {PascalList Row}
   Row | {PascalList
	  {AddList {ShiftLeft Row}
	   {ShiftRight Row}}}
end

declare
fun {PascalList2 N Row}
   if N==1 then [Row]
   else
      Row | {PascalList2 N-1
	     {AddList {ShiftLeft Row}
	      {ShiftRight Row}}}
   end
end

declare
fun {GenericPascal Op N}
   if N==1 then [1]
   else L in
      L = {GenericPascal Op N-1}
      {OpList Op {ShiftLeft L} {ShiftRight L}}
   end
end
fun {OpList Op L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 {Op H1 H2} | {OpList Op T1 T2}
      end
   else nil
   end
end
fun {Add X Y} X+Y end
fun {Xor X Y} if X==Y then 0 else 1 end end

declare X in
thread {Delay 5000} X=99 end
{Browse start} {Browse X*X}

declare X in
thread {Browse start} {Browse X*X} end
{Delay 5000} X=99

declare
C = {NewCell 0}
C := @C + 1
{Browse @C}

declare
C={NewCell 0}
fun {FastPascal N}
   C:=@C+1
   {GenericPascal Add N}
end

declare
local C in
   C={NewCell 0}
   fun {Bump}
      C:=@C+1
      @C
   end
   fun {Read}
      @C
   end
end

declare
fun {NewCounter}
   C Bump Read in
   C={NewCell 0}
   fun {Bump}
      C:=@C+1
      @C
   end
   fun {Read}
      @C
   end
   counter(bump:Bump read:Read)
end

declare
Ctr1={NewCounter}
Ctr2={NewCounter}
{Browse {Ctr1.bump}}
{Browse {Ctr2.bump}}
{Browse {Ctr2.read}}

% DATAFLOW is a behavior in which an operation would simply wait when it tries
% to use a variable that is not yet bound, perhaps some other thread will bind
% the variable , and then the operation can continue.

% RACE CONDITION
%
% Race condition is an observable nondeterminism.  When a program has both
% concurrency and state, it can give different results from one execution to
% the next.  This is because the order in which threads access the state can
% change from one execution to the next.  The variability is called
% nondeterminism.  Nondeterminism exists because we lack knowledge of the exact
% time when each basic operation executes, since the threads are independent.
% If the nondeterminism shows up in the program , it is observable.
declare
C={NewCell 0}
thread
   C:=2
end
thread
   C:=1
end
{Browse @C}

declare
C={NewCell 0}
thread I in
   I=@C
   C:=I+1
end
thread J in
   J=@C
   C:=J+1
end

% implement atomic operation by lock
declare
C={NewCell 0}
L={NewLock}
thread
   lock L then I in
      I=@C
      C:=I+1
   end
end
thread
   lock L then J in
      J=@C
      C:=J+1
   end
end

% Lessons learned
%
% 1. If possible try to avoid concurrency and state together.
% 2. Encapsulate state and communicate between threads using dataflow.
% 3. Try to master interleavings by using atomic operations.

declare
X=person(name:"George" age:25 8 5 6 20)
{Browse X}
{Browse {Arity X}}
{Browse {Label X}}
{Browse X.age}
{Browse X.1}
{Browse X.name}

declare
X=true(name:literal age:'twenty-five-atom')

%% procedure semantics

% What is the value of Y?
% It has to be the value of Y when the procedure is DEFINED.
proc {LB X ?Z}
   if X>=Y then Z=X else Z=Y end
end

local Y LB in
   Y=10
   proc {LB X ?Z}
      if X>=Y then Z=X else Z=Y end
   end
   local Y=15 Z in
      {LB 5 Z}
      {Browse Z}
   end
end

declare
proc {Loop10 I}
   if I==10 then skip
   else
      {Browse I}
      {Loop10 I+1}
   end
end
{Loop10 0}

local LowerBound Y C in
   Y=5
   proc {LowerBound X ?Z}
      if X>=Y then Z=X else Z=Y end
   end
   {LowerBound 3 C}
   {Browse C}
end

local LowerBound Y C in
   Y=5
   proc {LowerBound X ?Z}
      if X>=Y then Z=X else Z=Y end
   end
   local Y in
      Y=10
      {LowerBound 3 C}
      {Browse C}
   end
end