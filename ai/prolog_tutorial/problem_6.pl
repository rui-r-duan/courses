file(X,Y) :-
	open(X,read,In,[eof_action(eof_code)]),
	readAll(In,Y),
	close(In).
readAll(In,C) :- get0(In,C).
