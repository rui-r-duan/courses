%%% Problem 1a
declare
fun {ProdRecursive Low High Acc}
   if Low == High then Low * Acc
   elseif Low > High then Acc
   else
      {ProdRecursive (Low+1) (High-1) (Low*High*Acc)}
   end
end
fun {ProdFromTo I J}
   if I =< J then
      {ProdRecursive I J 1}
   else
      {ProdRecursive J I 1}
   end
end

{Browse {ProdFromTo 3 10}}	% => 1814400
{Browse {ProdFromTo 10 2}}	% => 3628800

%%% Problem 1b
declare
fun {SumRecursive Low High Acc}
   if Low == High then Low + Acc
   elseif Low > High then Acc
   else
      {SumRecursive (Low+1) (High-1) (Low+High+Acc)}
   end
end
fun {SumFromTo I J}
   if I =< J then
      {SumRecursive I J 0}
   else
      {SumRecursive J I 0}
   end
end

{Browse {SumFromTo 1 10}}	% => 55
{Browse {SumFromTo ~10 1}}	% => ~54

%%% Problem 1c
%%% Tail Recursion optimized
%% Pre: N >= 0
declare
fun {CountRecursive N Acc}
   if N == 0 then
      Acc
   else
      {CountRecursive (N-1) N|Acc}
   end
end
declare
fun {Count N}
   {CountRecursive N nil}
end

{Browse {Count 10}}		% => [1 2 3 4 5 6 7 8 9 10]
{Browse {Count 1}}		% => [1]
{Browse {Count 0}}		% => nil

%%% Problem 2a
%%% Tail Recursion Optimized
declare
fun {ListLength Xs}
   fun {Len Xs Length}
      case Xs
      of nil then Length
      [] _|T then {Len T (Length+1)}
      end
   end
in
   {Len Xs 0}
end

{Browse {ListLength a|b|c|nil}}	% => 3
{Browse {ListLength [a]}}	% => 1
{Browse {ListLength nil}}	% => 0

%%% Problem 2b
declare
fun {P Xs}
   fun {PRecursive Xs Acc}
      case Xs
      of nil then Acc
      [] H|T then {PRecursive T (H * Acc)}
      end
   end
in
   {PRecursive Xs 1}
end

{Browse {P [4 1 2 3]}}		% => 24
{Browse {P nil}}		% => 1
{Browse {P [~2]}}		% => ~2
{Browse {P [3 5 9 28 ~3552 0]}}	% => 0

%%% Problem 3
% declare
% fun {Append Xs Ys}
%    case Xs of nil then Ys
%    [] H|T then
%       H | {Append T Ys}
%    end
% end
%% Use List.append instead of my Append.
declare
fun {Flat Xs}
   if Xs== nil then nil
   elseif {List.is Xs.1} then
      {List.append {Flat Xs.1} {Flat Xs.2}}
   else
      Xs.1 | {Flat Xs.2}
   end
end

{Browse {Flat [1[2[3 4 5 ] 6] 7]}} % => [1 2 3 4 5 6 7]
{Browse {Flat [1 [2 [3 4 5] [6 5 [11 12]]] 7 [88 99]]}} % => [1 2 3 4 5 6 5 11 12 7 88 99]

%%% Problem 4
declare
local
   fun {Loop Xs Changed ?IsSorted}
      case Xs
      of X1|X2|Xr andthen X1 > X2 then
	 X2|{Loop X1|Xr true IsSorted}
      [] X|Xr then
	 X|{Loop Xr Changed IsSorted}
      [] nil then
	 IsSorted = {Not Changed}
	 nil
      end
   end
in
   fun {BubbleSort Xs}
      IsSorted
      Result = {Loop Xs false ?IsSorted}
   in
      if IsSorted then Result
      else {BubbleSort Result}
      end
   end
end

{Browse {BubbleSort [3 1 4 1 5 9 2 6 5]}} % => [1 1 2 3 4 5 5 6 9]

{Browse div

%%% Problem 5
declare SqrtIter Improve Average IsGoodEnough Square Sqrt
fun {SqrtIter Guess X}
   if {IsGoodEnough Guess X} then Guess
   else
      {SqrtIter {Improve Guess X} X}
   end
end
fun {Improve Guess X}
   {Average Guess (X/Guess)}
end
fun {Average X Y}
   {Float.'/' (X + Y) 2.0}	% Only accept Floats
end
fun {IsGoodEnough Guess X}
   {Number.abs ({Square Guess} - X)} < 0.0001
end
fun {Square X}
   X * X
end
fun {Sqrt X}
   {SqrtIter 1.0 X}
end

{Browse {Sqrt 121.0}}		% => 11.0
{Browse {Sqrt 2.0}}		% => 1.4142
