%%% Single Assignment Store
declare
V = 10-5
V = 4				% error
%***************************** failure **************************
%**
%** Tell: 5 = 4
%**
%** Call Stack:
%** toplevel abstraction in line 1, column 0, PC = 48469216
%**--------------------------------------------------------------
%% anything here is ignored (after error)
{Browse 'never prints'}

declare
V = 10-5
V = 4+1
%% on compatible assignment, computation preceeds
{Browse V}

%%% From Partial Values to Value Store
declare Y X
X = person(name:"George" age:Y)
Y=25
{Browse X}

declare X Y Z
X = person(name:"George" age:Z)
%% incompatible assignment
%X = person(name:"David" age:Z)
%% compatible assignment
X = person(name:Y age:25)

{Browse X}
{Browse Y}
{Browse Z}

%%% declare scope
declare
X = 5				% after declare, X can be rebound
local
X = 6
in
{Browse X}
end

declare
X = 88

{Browse X}

%%% Variable to Variable  Binding
%%% Variables can be bound to variables.
%%% They form an equivalence set of store variables after such binding.
%%% They throw exception if their values are different.
declare X1 X2 X3 X4 X5 X6 in
%% (Feed the lines below one at a time...)
{Browse store(x1:X1 x2:X2 x3:X3 x4:X4 x5:X5 x6:X6)}
X1=X2
X3=X2
X5=name(label:7)
X6=name(label:X1)
X1=X4
X5=X6

%%% Dataflow Variables
declare X Y
Y = X + 1
{Browse Y}
X = 2

declare A B C
C = A + B
{Browse C}
A = 10
B = 20

%%% Dataflow Variables for Controlling Concurrency
declare X Y Z
thread
   Z = X + Y		    % will wait until both X and Y are bound to a value
   {Browse Z}
end
thread X = 40 end
thread Y = 2 end

%%% An Element Position
declare
fun {Position Xs Y}
   case Xs of nil then 0
   [] H|T then
      if H==Y then
	 1
      else
	 1+{Position T Y}
      end
   end
end
A = [1 2 3 4 166 4]
{Browse {Position A 166}}

%%% List Membership
declare
fun {Member Xs Y}
   case Xs of nil then false
   [] H|T then
      if H==Y then
	 true
      else
	 {Member T Y}
      end
   end
end
A=[1 2 3 4]
{Browse {Member A 2}}

%%% Take and Drop List Heads
declare
fun {Take Xs N}
   if N<1 then
      nil
   else
      case Xs of nil then nil
      [] H|T then
	 H | {Take T N-1}
      end
   end
end
A = [1 2 3 4 5 6]
{Browse {Take A 3}}

declare
fun {Drop Xs N}
   if N<1 then
      Xs
   else
      case Xs of nil then nil
      [] _|T then
	 {Drop T N-1}
      end
   end
end
A = [1 2 3 4 5]
{Browse {Drop A 6}}

%%% Appending two lists
declare
fun {Append Xs Ys}
   case Xs of nil then Ys
   [] H|T then
      H | {Append T Ys}
   end
end

%%% Sabah's version
declare
fun {Append_2 Xs Ys}
   case Xs of nil then
      case Ys of nil then nil
      [] H|T then
	 H | {Append nil T}
      end
   [] H|T then
      H | {Append T Ys}
   end
end

{Browse {Append [1 2 3] [4 5 6]}}
{Browse {Append nil [4 5 6]}}
{Browse {Append [1 2 3] nil}}
{Browse {Append nil nil}}
{Browse {Append [1] [2]}}
declare
A = [1 2 3]
B = [4 5 6]
C = {Append A B}
{Browse C}
declare
B = [7 8 9]
{Browse B}
{Browse C}

%%% Reversing a List
declare
fun {Reverse Xs}
   case Xs of nil then nil
   [] X|T then
      {Append {Reverse T} [X]}
   end
end
local Z in
   Z = {Reverse [1 2 3 4]}
   {Browse Z}
end
{Browse [1]}
{Browse [1 2]}

%%% Factorial Tail Recursive: Using Auxiliary Function
declare
fun {Fact N}
   case N
   of 0 then 1
   [] X then X * {Fact X-1}
   end
end

{Browse ['Fact(233) = ' {Fact 233}]}

declare
fun {Fact2 N}
   fun {FactIter N Acc}
      if N == 0 then
	 Acc
      else
	 {FactIter N-1 Acc*N}
      end
   end
in
   {FactIter N 1}
end

{Browse {Fact2 233}}

%%% Fibo Tail Recursive
declare
fun {FiboTwo N A1 A2}
   case N of
      1 then A1
   [] 2 then A2
   [] M then {FiboTwo (M-1) A2 (A1+A2)}
   end
end
{Browse {FiboTwo 100 1 1}}

%%% Quick Sort
declare Partition
fun {Quicksort L}
   % Use Head of List Element for Partitioning
   case L
   of X|L2 then Left Right SL SR in
      {Partition L2 X Left Right}
      SL = {Quicksort Left}
      SR = {Quicksort Right}
      {Append SL X|SR}
   [] nil then nil
   end
end
proc {Partition L2 X L R}
   case L2
   of Y|M2 then
      if Y<X then Ln in
	 L = Y|Ln
	 {Partition M2 X Ln R}
      else Rn in
	 R = Y|Rn
	 {Partition M2 X L Rn}
      end
   [] nil then L = nil R = nil
   end
end

local L R in
   {Partition [2 3 4 5 6] 5 L R}
   {Browse L#R}
end

%%% Tail Recursive Quick Sort
declare
proc {Quicksort L S1 S0}
   case L
   of X|L2 then Left Right S2 S3 in
      {Partition L2 X Left Right}
      {Quicksort Left S1 S2}	% When is S2 bound?
      S2 = X|S3
      {Quicksort Right S3 S0}
   [] nil then S1 = S0
   end
end

local S in
   {Quicksort [3 2 4 3 5 4 3 2 3] S nil}
   {Browse S}
end

%%% My exploration: what blocks execution?
declare
fun {WaitAdd X Y Z}
   Z = 9999
   X + Y % this kind of expression evaluates to a value and must be put at the end of a function
end
% Blocked, display nothing, Y = 5 has no chance to be executed
local Y Z
in
   {Browse {WaitAdd 3 Y Z}}
   Y = 5
   {Browse Z}
end
declare
fun {WaitAdd X Y}
   X + Y
end
% Blocked, display nothing, "thread Y = 5 end" gets no chance to be executed
local Y
in
   {Browse {WaitAdd 3 Y}}
   thread Y = 5 end
end
% Good
local Y
in
   thread {Browse {WaitAdd 3 Y}} end
   thread Y = 5 end
end

%%% Double
declare
fun {Double Ls}
   case Ls of nil then nil
   [] H|T then (2*H) | {Double T} end
end

%%% Tail recursive Double
declare
fun {Double2 Ls}
   %% Helper function
   fun {InDouble2 Li Ta}
      case Ta of nil then Li
      [] H|T then {InDouble2 {Append Li [(H*2)]} T}
      end
   end
in
   {InDouble2 nil Ls}
end

local L in
   L = [1 2 3 4]
   {Browse {Double2 L}}
end

%%% Difference Lists
declare X Y L3
L3 = (1|2|3|X)#Y
X = (4|5|Y)
{Browse X}
{Browse L3}

%%% Append using difference list
declare
fun {AppendD D1 D2}
   S1 # E1 = D1
   S2 # E2 = D2
in
   E1 = S2			% if E1 == S2, then S1 must be [1 2 3 4 5]
   S1 # E2
end

local X Y in
   {Browse {AppendD (1|2|3|X)#X (4|5|Y)#Y}}
end

%***************************** failure **************************
%**
%** Tell: 1|2|3 = _<optimized>#_<optimized>
%**
%** Call Stack:
%** procedure 'AppendD' in file "c:/Users/Ryan/code/courses/pl/L3_scratch.oz", line 345, column 0, PC = 43181404
%**--------------------------------------------------------------
local X Y in
   {Browse {AppendD (1|2|3) (4|5)}}
%% COMMENT: Cannot pattern matching 1|2|3 with S1#E1 without other help
end

%%% COMMENT: the following code test what op blocks the thread
%%% '+' blocks the thread
local X in
   {Browse 3+X}
end

%%% '|' does not block the thread
local X in
   {Browse 3|X}			% => 3|_
end

%%% '#' does not block the thread
local X in
   {Browse 3#X}			% => 3#_
end

local X in
   {Browse X}			% => _
end

%*************************** type error *************************
%**
%** equality constraint failed
%**
%** First type:         atom
%** Second type:        char
%** First value:        hello
%** Second value:       5
%** Original assertion: hello = 5
%** in file "c:/Users/Ryan/code/courses/pl/L3_scratch.oz", line 377, column 11
%** ------------------ rejected (1 error)
local
   hello = 5
in
   {Browse hello}		% COMMENT: Variable's first letter must be Capitalized!
end

{Browse [1 2]#[1 2] == nil}	% false
{Browse X}			% 4|5|Y
{Browse Y}
{Browse [1|X]#X == [1]}		% false

%%% Reverse a list using the diff list
declare
fun {Reverse3 Xs}
   local Y in
      case Xs of
	 nil then Y#Y
      [] H|T then
	 % local
	 A B C in
	 A#B = {Reverse3 T}
	 B = H|C		% COMMENT: the same as H|C = B
	 A#C
	 % end
      end
   end
end

{Browse {Reverse3 nil}}
{Browse {Reverse3 [a]}}
{Browse {Reverse3 [a b]}}
{Browse {Reverse3 [1 2 3]}}

%%% Eager evaluation
declare
fun {Ints N Max}
   if N<Max then
      {Delay 1000}
      N | {Ints N+1 Max}
   else
      nil
   end
end
fun {Sum A Xs}
   case Xs of X|Xr then
      A | {Sum A+X Xr}
   [] nil then nil
   end
end
%% "Batch": sequential computation
declare Xs Ys in
{Browse Xs}
{Browse Ys}
Xs = {Ints 1 10}
Ys = {Sum 0 Xs}

%%% Lazy evaluation
declare
fun lazy {LazyInts N Max}
   if N<Max then
      {Delay 1000}
      N | {LazyInts N+1 Max}
   else
      nil
   end
end
fun lazy {LazySum A Xs}
   case Xs of X|Xr then
      A | {LazySum A+X Xr}
   [] nil then nil end
end
%% Lazy: no calculation until requested
declare Xs Ys in
{Browse Xs}
{Browse Ys}
Xs = {LazyInts 1 10}
Ys = {LazySum 0 Xs}
% Request a result triggers calculation
{Browse Ys.2.1}
{Browse Ys.2.2.2.1}
{Browse Ys.2.2.2.2.2.2.1}

%%% A Stack ADT using lists (open, declarative, unbundled)
declare NewStack Push Pop IsEmpty in
fun {NewStack} nil end
fun {Push S E} E|S end
fun {Pop S E}
   case S of
      X|S1 then
      E = X
      S1
   end
end
fun {IsEmpty S}
   S == nil
end

local S1 S2 V in
   S1 = {Push {Push {NewStack} 1} 2}
   {Browse S1}
   S2 = {Pop S1 V}
   {Browse V}
   {Browse S2}
   case S2 of H|_ then {Browse H} end
end

declare
fun {NewQueue} q(nil nil) end
fun {Check Q}
   case Q of q(nil R) then q({Reverse R} nil) else Q end
end
fun {Insert Q X}
   case Q of q(F R) then {Check q(F X|R)} end
end
fun {Delete Q X}
   case Q of
      X = q(nil nil) then X   % COMMENT: can introduce local vars in predicate of a case
   [] q(F R) then
      F1 in
      F = X|F1
      {Check q(F1 R)}
   end
end

declare Q1 Q2 Q3 Q4 Q5
Q1 = {NewQueue}
{Browse Q1}
Q2 = {Insert Q1 a}
{Browse Q2}
Q3 = {Insert Q2 b}
{Browse Q3}
Q4 = {Insert Q3 c}
{Browse Q4}

local X in
   Q5 = {Delete Q4 X}
   {Browse X}
   {Browse Q5}
end

local Result in
   Result = {Delete {NewQueue} c}
   {Browse Result}
end

local Result in
   {Browse {Delete {NewQueue} c}}
end

%********************** static analysis error *******************
%**
%** illegal arity in application
%**
%** Arity found:          2
%** Expected:             3
%** Application (names):  {Delete _ _}
%** Application (values): {<P/3 Delete> _<optimized> c}
%** in file "c:/Users/Ryan/code/courses/pl/L3_scratch.oz", line 552, column 3
%** ------------------ rejected (1 error)
local Result in
   {Delete {NewQueue} c}
end

declare
fun {NewCounter}
   local C Bump in
      C = {NewCell 0}
      fun {Bump}
	 {Assign C {Access C}+1}
	 {Access C}
      end
      Bump
   end
end

declare Ctr1 = {NewCounter}
declare Ctr2 = {NewCounter}
{Browse {Ctr1}}
{Browse {Ctr1}}
{Browse {Ctr1}}
{Browse {Ctr2}}
{Browse {Ctr1}}
{Browse {Ctr2}}

%%% COMMENT: This kind of syntax is obscure!
%%% not the same effect as {NewCounter}
declare
fun {RyanCounter}
   local X in
      X = 0
      fun {Counter}
	 X+1
      end
   end
in
   {Counter}
   % Counter    % cannot add this line, will result in compilation error
end

{Browse {RyanCounter}}
{Browse {RyanCounter}}

local
   class Counter
      attr i			 % define attribute i
      meth init(I) i := I end	 % bind i to arg I
      meth get(I) I=@i end	 % return i
      meth incr i := @i+1 end	 % increment i by one
   end
%*************************** type error *************************
%**
%** ill-typed builtin application
%**
%** Builtin:         Object.new
%** At argument:     2
%** Expected types:  'class' x record x value
%** Argument names:  {Object.new Counter _ MyCounter}
%** Argument values: {Object.new <C: Counter> 3 MyCounter<optimized>}
%** in file "c:/Users/Ryan/code/courses/pl/L3_scratch.oz", line 613, column 15
%** ------------------ rejected (1 error)
  % MyCounter = {New Counter 3}
%********************** static analysis error *******************
%**
%** illegal arity in application
%**
%** Arity found:     2
%** Expected:        3
%** Argument names:  {Object.new Counter MyCounter}
%** Argument values: {<P/3 Object.new> <C: Counter> MyCounter<optimized>}
%** in file "c:/Users/Ryan/code/courses/pl/L3_scratch.oz", line 625, column 15
%** ------------------ rejected (1 error)
   % MyCounter = {New Counter}
   MyCounter = {New Counter init(3)}
in
   {Browse {MyCounter get($)}}
   local X in
      {MyCounter get(X)}
      {Browse X}
   end
%********************** static analysis error *******************
%**
%** illegal number of arguments in object application
%**
%** Object:       MyCounter
%** Number found: 2
%** Expected:     1
%** in file "c:/Users/Ryan/code/courses/pl/L3_scratch.oz", line 644, column 14
%** ------------------ rejected (1 error)
   % local X in
   %    {Browse {MyCounter get(X)}}
   % end
   {MyCounter incr}
   {Browse {MyCounter get($)}}
end