%%%----------------------------------------------------------------------------
%%% This file provides a function {Pascal N} which returns the Nth row of the
%%% variation of Pascal Triangle (N begins from 1).
%%%
%%% author: Rui Duan (0561866)
%%%----------------------------------------------------------------------------

declare
% R: row index begins from 1
% C: collumn index begins from 0
fun {Term R C}
   if R==1 andthen C==0 then 1
   elseif R==2 andthen C==0 then 1
   elseif R==2 andthen C==1 then 1
   else
      {SumList {LeftDiagonal R C}} + {SumList {RightDiagonal R C}}
   end
end
fun {SumList Xs}
   fun {SumHelper S Xs}
      case Xs
      of nil then S
      [] H|T then {SumHelper H+S T}
      end
   end
in
   {SumHelper 0 Xs}
end
fun {LeftDiagonal R C}
   if C=<0 then nil
   else {Term R-1 C-1} | {LeftDiagonal R-1 C-1}
   end
end
fun {RightDiagonal R C}
   if R<1 then nil
   else {Term R-1 C} | {RightDiagonal R-1 C}
   end
end
% {Pascal N} returns the Nth row (N begins from 1) of the new Pascal Triangle
fun {Pascal N}
   fun {CollectTerms Col}
      if Col<0 then nil
      else
	 {Term N Col} | {CollectTerms Col-1}
      end
   end
in
   {CollectTerms N-1}
end
