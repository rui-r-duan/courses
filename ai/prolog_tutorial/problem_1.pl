edge(a,b).
edge(a,f).
edge(b,c).
edge(c,d).
edge(c,e).
edge(e,d).
edge(f,g).
edge(f,c).
edge(f,e).
edge(g,c).

tedge(Node1,Node2) :-
	edge(Node1,SomeNode),
	edge(SomeNode,Node2).

tripleedge(Node1,Node2) :-
	edge(Node1,A),
	edge(A,B),
	edge(B,Node2).

tripleedge2(Node1,Node2) :-
	edge(Node1,A),
	tedge(A,Node2).
