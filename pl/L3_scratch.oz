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
      {Quicksort Left S1 S2}
      S2 = X|S3
      {Quicksort Right S3 S0}
   [] nil then S1 = S0
   end
end

local S in
   {Quicksort [3 2 4 3 5 4 3 2 3] S nil}
   {Browse S}
end