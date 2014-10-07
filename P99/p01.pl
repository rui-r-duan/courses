%%% Find the last element of a list.
last_elem(X, [X]).
last_elem(X, [_|T]) :- last_elem(X, T).