%%% Find eht K'th element of a list.
%%% The first element in the list is number 1 (index begins from 1).

% element_at(X,L,K) :- X is the K'th element of the list L
%     (element,list,integer) (?,?,+)

% Note: nth1(?Index, ?List, ?Elem) is predefined

element_at(X,[X|_],1).
element_at(X,[_|T],K) :-
	K > 1,
	K1 is K-1,
	element_at(X,T,K1).
