mem(X,[H|T]) :- X == H.
mem(X,[H|T]) :- mem(X,T).