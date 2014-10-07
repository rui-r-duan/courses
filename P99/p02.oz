%%% Find the last but one element of a list.
declare
fun {LastButOne Xs}
   case Xs
   of nil then nil
   [] _|X|nil then X
   [] _|T then {LastButOne T}
   end
end

{Browse {LastButOne nil}}	% parse error if {LastButOne []}
{Browse {LastButOne [a]}}
{Browse {LastButOne [a b]}}
{Browse {LastButOne [a b c]}}
