declare
fun {Max X Y}
   if X > Y then X
   else Y
   end
end

{Browse {Max 3 5}}

declare
fun {MaxOfThree X Y Z}
   {Max {Max X Y} Z}
end

{Browse {MaxOfThree 3 23 9}}

declare
X

{Show X}

X = 5
{Show X}

X=6
%*************************** type error *************************
%**
%** ill-typed builtin application
%**
%** Builtin:         Number.'-'
%** At argument:     1
%** Expected types:  number x number x number
%** Argument names:  {Number.'-' Show _ _}
%** Argument values: {Number.'-' <P/1 System.show> 2 _<optimized>}
%** in file "c:/Users/Ryan/code/courses/pl/L1_scratch.oz", line 80, column 6
%** ------------------ rejected (1 error)

declare Y Z in			% the following scope is valid for Y and Z
Y = fred(3 Z [1 2 3])

{Browse Y}
Z = 100

local
   X = 1 + 1
   Y
in
   Y = 3
   {Browse X*Y}
   {Browse Z}			% shadowed the outer Z? Yes
   {Browse Y}			% shadowed the outer Y? Yes
end

local X in
   X=23
   local X in
      X=44
   end
   {Browse X}
end

%%% Declaring Procedures
local
   X
   %% procedure definition
   proc {Max X Y Z}		% just like passing by reference
      if X >= Y then Z = X
      else Z = Y end
   end
in
   %% procedure application
   {Max 4 3 X}
   {Browse X}
end

%%% Functions as Procedures
local
   X
   %% function definition
   fun {Max X Y}
      if X >= Y then X else Y end
   end
in
   %% function application like a procedure
   {Max 4 3 X}
   {Browse X}
end

%%% Procedures as Functions
local
   X
   %% procedure definition
   proc {Max X Y Z}
      if X >= Y then Z = X else Z = Y end
   end
in
   %% procedure application like a function
   X = {Max 4 3}
   {Browse X}
end

local
   X = person(name:'George' age:25)
in
   {Show {Arity X}}
   {Show {Label X}}
   {Show X.age}
end
declare
V=9999
X=V*V
{Show [V X]}			%[9999 9980001]

declare
V=33
{Show [V X]}			%[33 9980001]

%%% OZ numbers
local I F C in
   I = 5
   F = 5.5
   C = &t
   {Browse [I F C]}
end

{Show ~3*2}

{Show 'ÄãºÃ'}
{Browse 'aÄãºÃp'}

declare
R = suit(shirt:beige pants:ochre socks:coral) % pants gets printed firstly
				% sort the arities alphabetically
{Browse R.shirt}
{Browse {Label R}}
{Browse {Arity R}}
{Browse {Width R}}
% declare    % does not need a 'declare' here
R2 = {AdjoinAt R shirt mauve}
{Browse R2}

declare
A = person(georges 25)
{Browse A}
{Browse {Width A}}
{Browse {Label A}}
{Browse A.1}
{Browse person(A.1 A.2)}

declare
X = state(1 a 2)
{Browse state}
{Browse X}
{Browse {Label X}}
{Browse {Width X}}
{Browse X.2}

%%% Tuple of trees
declare
Y = l(1 2)
Z = r(3 4)
X = m(Y Z)
%{Browse [X.1 X.2 X.3]}
%********************** static analysis error *******************
%**
%** illegal feature selection on record
%**
%** Feature found:   3
%** Expected one of: {1, 2}
%** in file "c:/Users/Ryan/code/courses/pl/L2_scratch.oz", line 162, column 18
%** ------------------ rejected (1 error)
{Browse [X.1 X.2]}

%%% Declaring a Binary Tree Using Tuples
declare
% T = tree (s 1  % !!! Do not accepts whitespace between tree and (
%************************** syntax error ************************
%**
%** expression at statement position
%**
%** in file "c:/Users/Ryan/code/courses/pl/L2_scratch.oz", line 180, column 2
%** ------------------ rejected (4 errors)
T = tree(s 1
	 tree(p 2
	      tree(i 4
		   tree(d 6 leaf leaf)
		   leaf)
	      leaf)
	 tree(t 3
	      leaf
	      tree(u 5 leaf leaf)
	     )
	)
{Browse T}
declare
proc {DFS Tree}
   case Tree of
      leaf then skip
   [] tree(K D Left Right) then
      {DFS Left}
      {DFS Right}
      {Browse K}
   else skip			% case nil
   end
end
{DFS T}

declare
Root = node(left:X1 right:X2 value:0)
X1 = node(left:X3 right:X4 value:1)
X2 = node(left:X5 right:X6 value:2)
X3 = node(left:nil right:nil value:3)
X4 = node(left:nil right:nil value:4)
X5 = node(left5)
X6 = node(left:nil right:nil value:6)
{Browse Root}
proc {Preorder X}
   if X \= nil then
      {Browse X.value}
      if X.left \= nil then {Preorder X.left} end
      if X.right \= nil then {Preorder X.right} end
   end
end
{Preorder Root}
{Show Preorder}
{Browse {Label Root}}
{Browse {Arity Root}}
{Browse {Width Root}}
{Browse Root.left}
proc {Postorder X}
   if X \= nil then
      if X.left \= nil then {Postorder X.left} end
      if X.right \= nil then {Postorder X.right} end
      {Browse X.value}
   end
end
{Postorder Root}
proc {Inorder X}
   if X \= nil then
      if X.left \= nil then {Inorder X.left} end
      {Browse X.value}
      if X.right \= nil then {Inorder X.right} end
   end
end
{Inorder Root}

{Browse X}
{Browse [1 2 X]}

%%% List: Head and Tail
{Inspect [a b c] == a|b|c|nil}
{Inspect [a b c] == '|'(a '|'(b '|'(c nil)))}
{Inspect [a b c].1}
{Inspect [a b c].2}

local Xs = [1 2 3 4]
in case Xs of H|T then
      {Inspect H}
      {Inspect T}
   end
end

declare
L=nil
{Browse L}
L2=a|L
{Browse L2}
L3=a|(b|(c|nil))
{Browse L3}
L4=a|b|c|nil
{Browse L4}

%%% List of Lists
declare
M = [ [1 2] [4 5] [6 7] ]
{Browse M}
fun {Dim M}
   dim(rows:{Length M} columns:{Length M.1})
end
{Browse {Dim M}}
{Browse {Dim [[1 2 4] [3 4 5] [5 6 7] [4 5 6]]}}

%%% Functions over Lists
declare
fun {Head Xs}
   Xs.1
end
fun {Tail Xs}
   Xs.2
end
{Browse {Head [a b c]}}
{Browse {Tail [a b c]}}
{Browse {Tail {Tail [a b c]}}}

%%% Pattern matching
declare
fun {SumList L}
   case L of
      nil then 0
   [] H|T then H + {SumList T}
   end
end
{Browse {SumList [1 2 3]}}

%%% Stack
declare NewStack Push Pop IsEmpty in
fun {NewStack}
   nil
end

fun {Push S E}
   E|S
end

fun {Pop S E}
   case S of
      X|S1 then
      E = X			% modify E !!!
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
   case S2 of H|_ then		% TODO
      {Browse H}
   end
end

%%% Pascal Triangle
declare ShiftLeft ShiftRight AddList
fun {Pascal N}
   if N == 1 then [1]
   else
      {AddList {ShiftLeft {Pascal N-1}}
               {ShiftRight {Pascal N-1}}}
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
      end
   else
      nil
   end
end

{Browse {Pascal 5}}

%%% Tail Recursive
declare
fun {Fact N}
   if N==0 then 1
   else
      N * {Fact N-1}
   end
end

{Browse {Fact 5}}
{Browse {Fact 10}}
{Browse {Fact 100}}
{Browse {Fact 5000}}

declare
fun {Fact2 N A}
   if N==0 then A
   else {Fact2 N-1 N*A}
   end
end

{Browse {Fact2 100 1}}

%%% Times as Tail Recursive
declare
fun {Times L N}
   case L
   of nil then nil
   [] X|L2 then X*N | {Times L2 N}
   end
end

%%% Generic Function of Times
declare
fun {Map L F}
   case L
   of nil then nil
   [] X|L2 then {F X} | {Map L2 F}
   end
end

declare
fun {Mul7 X}
   X*7
end

{Browse {Map [1 2 3] Mul7}}
{Browse {Map [1 2 3 4] fun {$ X} X*X end}}

%%% Filter (Higher Ordered Functions)
declare
fun {Filter Xs P}
   case Xs
   of nil then nil
   [] X|Xr andthen {P X} then
      X|{Filter Xr P}
   [] _|Xr then {Filter Xr P}
   end
end
{Browse {Filter [1 2 3 8 7 ~3 ~2 ~6 4] fun {$ A} A mod 2 == 0 end}}

%%% Tree Size
declare
fun {Size T}
   case T
   of nil then 0
   [] tree(_ LT RT) then 1 + {Size LT} + {Size RT}
   end
end
{Browse {Size tree(a tree(b nil tree(c nil nil)) tree(d nil nil))}}

%%% Tree Depth
declare
fun {Depth T}
   case T
   of nil then 0
   [] tree(_ LT RT) then 1 + {Max {Depth LT} {Depth RT}}
   end
end
{Browse {Depth tree(a tree(b nil tree(c nil nil)) tree(d nil nil))}}
