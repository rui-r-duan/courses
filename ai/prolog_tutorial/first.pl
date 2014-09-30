edge(a,b).
edge(a,e).
edge(b,d).
edge(b,c).
edge(c,a).
edge(e,b).

% edge(X,Y) :- tedge(X,Y).

tedge(Node1,Node2) :-
    edge(Node1,SomeNode),
    edge(SomeNode,Node2).

path(Node1,Node2) :-
	edge(Node1,Node2).
path(Node1,Node2) :-
	edge(Node1,SomeNode),
	path(SomeNode,Node2).

chain(X,Y,[X,Y]) :- edge(X,Y).
chain(X,Y,[X|Z]) :- edge(X,I), path(I,Y), chain(I,Y,Z).
chain(X,Y,[]).
