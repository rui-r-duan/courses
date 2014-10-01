factorial(0,1).
factorial(N,F) :-
	N>0,
	N1 is N-1,
	factorial(N1,F1),
	F is N * F1.

factorial2(0,F,F).
factorial2(N,A,F) :-
	N > 0,
	A1 is N*A,
	N1 is N-1,
	factorial2(N1,A1,F).

%% The order of f(a) and f(b) affects the amount of computation.
f(b).
g(a).
g(b).
h(b).
f(a).
k(X) :- f(X), g(X), h(X).

%% The order of the following rules affects the amount of computation for
%% minimum(1,2,X).
minimum(X,Y,X) :- X=<Y.
minimum(X,Y,Y) :- X>Y.

%%% Cut Operator '!'
gc_minimum(X,Y,X) :- X=<Y, !.
gc_minimum(X,Y,Y) :- X>Y.

r(a).
r(b).
s(a).
s(b).
s(c).

%%% fail Operator
%%% Iterative Rule
happy(harry).
happy(ron).
happy(hermione).
happy(hagrid).
write_everybody_happy :-
	happy(X),
	write(X), nl,
	fail.
write_everybody_happy :- true.

%%% fail and !
animal(yogi).
cat(tom).
bear(yogi).
animal(tom).
likes(colbert,X) :- bear(X), !, fail.
likes(colbert,X) :- animal(X).

enjoys(vincent,X) :-
	big_kahuna_burger(X),!,fail.
enjoys(vincent,X) :- burger(X).
burger(X) :- big_mac(X).
burger(X) :- big_kahuna_burger(X).
burger(X) :- whopper(X).
big_mac(a).
big_kahuna_burger(b).
big_mac(c).
whopper(d).

%%% List
cost(cornflakes,230).
cost(cocacola,210).
cost(chocolate,250).
cost(crisps,190).
total_cost([],0).
total_cost([Item|Rest],Cost) :-
	cost(Item,ItemCost),
	total_cost(Rest,CostOfRest),
	Cost is ItemCost + CostOfRest.

%% append/3
append([],A,A).			% append [] and A, the result is A.
append([H|Ta],B,[H|Tc]) :-	% append [H|Ta] and B, the result is Tc
	append(Ta,B,Tc),!.	% where Tc is the result of appending Ta and B.

%%% remove duplicates
remove_dups([], []).
remove_dups([First|Rest],NewRest) :-
	member(First,Rest),	% After one result is completely produced,
				% prolog backtracks here and gives a fail on
				% member(First,Rest), which is member's
				% behavior.  So we need a Cut here to avoid
				% unnecessary backtracking.
	remove_dups(Rest,NewRest).
remove_dups([First|Rest],[First|NewRest]) :-
	not(member(First,Rest)), % when unification and resolution come to this
	                         % point, the previous predicate has confirmed
	                         % that 'First' is not member of 'Rest', so
	                         % this term is a redundant computation.
				 %
				 % Actually, we can remove this term, the
				 % result is the same, but prolog still does
				 % backtracking on 'member' term of the previous
				 % predicate.
	remove_dups(Rest,NewRest).

%%% remove duplicates using Cut
remove_dups([],[]).
remove_dups([First|Rest],NewRest) :-
	member(First,Rest),
	!,
	remove_dups(Rest,NewRest).
remove_dups([First|Rest],[First|NewRest]) :-
	remove_dups(Rest,NewRest).

%%% Why put Cut after 'member(First,Rest)'?
%%% Refer to remove_dups_cut_analysis.txt

%%% Searching the Graph
%%% 'edge' must be defined (loaded) before using it in predicates.
edge(1,5).
edge(1,7).
edge(2,1).
edge(2,7).
edge(3,1).
edge(3,6).
edge(4,3).
edge(4,5).
edge(5,8).
edge(6,4).
edge(6,5).
edge(7,5).
edge(8,6).
edge(8,7).
path(Node,Node,_,[Node]).
path(Start,Finish,Visited,[Start|Path]) :- % if the body is true,
				% add Start to Path
	edge(Start,X),		% X connects to Start
	not(member(X,Visited)),	% X has not been visited
	path(X,Finish,[X|Visited],Path). % if there is a path from X to Finish
				% then, add X to Visited

%%% Representing Stack using List
empty_stack([]).
stack(Top,Stack,[Top|Stack]).
member_stack(Element,Stack) :-
	member(Element,Stack).

%%% Binary Tree
%%% in the form
%%%     tree(Left, Data, Right)

% tree(tree(empty, jack, empty), fred, tree(empty, jill, empty)).

tt_tree(empty).
tt_tree(tree(Left,Data,Right)) :-
	tt_tree(Left),
	write(Data),nl,
	tt_tree(Right).
tree_size(empty,0).
tree_size(tree(L,_,R),Total_Size) :-
	tree_size(L,Left_Size),
	tree_size(R,Right_Size),
	Total_Size is Left_Size + Right_Size + 1.

%%% Count leaves of binary tree
count_leaves1(nil,0).
count_leaves1(t(_,nil,nil),1) :- !. % don't match the following predicates
				% for t(_,nil,nil)
count_leaves1(t(_,L,R),N) :-
	count_leaves1(L,NL),
	count_leaves1(R,NR),
	N is NL+NR.