%%% Find the last element of a list.
declare
fun {LastElem Xs}
   case Xs
   of nil then nil
   [] _|T then
      case T
      of nil then nil
      [] T|nil then T
      else {LastElem T}
      end
   end
end

{Browse {LastElem [1 2 [3 5] b]}}

% {Browse {LastElem []}}
%*************************** parse error ************************
%**
%** syntax error, unexpected T_CHOICE, expecting '}'
%**
%** in file "c:/Users/Ryan/code/courses/P99/p01.oz", line 16, column 18
%** ------------------ rejected (1 error)

{Browse {LastElem nil}}
