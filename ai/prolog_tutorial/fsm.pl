%%% Finite State Machine Simulator
accept(S) :- start(s), accept(Q,S).
accept(Q, [X|XS]) :-
	delta(Q,X,Q1),
	accept(Q1,XS).
accept(F,[]) :- final(F).

start(s).
final(f1).
final(f2).
delta(s,a,q1).
delta(q1,a,f1).
delta(q2,a,s).
delta(q2,b,f2).
delta(s,b,q2).
delta(q1,b,s).