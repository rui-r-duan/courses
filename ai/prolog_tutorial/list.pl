append([], List, List).		% bodiless rule
append([H|Tail], X, [H|NewTail]) :- append(Tail, X, NewTail).

reverse([],[]).			% reversing an empty list is the empty list
reverse([H|Tail],Result) :-	% to reverse a non-empty list,
	reverse(Tail,Tailreversed), % first reverse the tail,
	append(Tailreversed,[H],Result). % append the result to the list [H].