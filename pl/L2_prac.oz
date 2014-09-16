declare
T = tree(s 1
	 tree(p 2
	      tree(i 4
		   tree(d 6 leaf leaf)
		   leaf)
	      tree(r 8
		   tree(x 5 leaf leaf)
		   leaf)
	      )
	 tree(t 3
	      nil		% %%
	      tree(u 5 leaf leaf)
	     )
	)
{Browse T}
{DFS T}

declare
Root = node(left:X1 right:X2 value:0)
X1 = node(left:X3 right:X4 value:1)
X2 = node(left:X5 right:X6 value:2)
X3 = node(left:nil right:nil value:3)
X4 = node(left:nil right:nil value:4)
X5 = node(left:nil right:nil value:5)
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

%%% DIY: Change SumList to Tail Recursive
declare
fun {SumListR L A}
   case L of
      nil then A
   [] X|L2 then {SumListR L2 A + X}
   end
end
{Browse {SumListR [1 3 5 7 9 11] 0}}

%%% DIY: Change Fibonacci to Tail Recursive
declare FibonacciR =
fun {$ N A Previous}
   if N == 0 then Previous
   elseif N == 1 then A
   else {FibonacciR N-1 A+Previous A}
   end
end
fun {Fibonacci N}
   {FibonacciR N 1 0}
end

{Browse {Fibonacci 0}}
{Browse {Fibonacci 1}}
{Browse {Fibonacci 15}}
{Browse {Fibonacci 22}}
{Browse {Fibonacci 30}}
{Browse {Fibonacci 40}}

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
