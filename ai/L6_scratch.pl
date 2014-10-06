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

%%% KB
% Different types of animal
isa(canary,bird).
isa(ostrich,bird).
isa(bird,animal).
isa(opus,penguin).
isa(robin,bird).
isa(penguin,bird).
isa(fish,animal).
isa(tweety,canary).
hasprop(animal,cover,skin).
hasprop(fish,travel,swim).
hasprop(bird,travel,fly).
hasprop(bird,cover,feathers).
hasprop(ostrich,sound,sing).
hasprop(ostrich,travel,walk).
hasprop(ostrich,sound,sing).
hasprop(robin,color,red).
hasprop(penguin,color,brown).
hasprop(penguin,travel,walk).
hasprop(canary,color,yellow).
hasprop(canary,sound,sing).
hasprop(tweety,color,white).
% Inheritance
hasproperty(Object,Property,Value) :- hasprop(Object,Property,Value).
hasproperty(Object,Property,Value) :-
	isa(Object,Parent),
	hasproperty(Parent,Property,Value).

%%% Representing Frames in Prolog
bird(a_kind_of, animal).
bird(moving_method, fly).
bird(active_at, daylight).
albatross(a_kind_of, bird).
albatross(color, black_and_white).
albatross(size, 115).
kiwi(a_kind_of, bird).
kiwi(moving_method, walk).
wiki(active_at, night).
wiki(color, brown).
wiki(size, 40).
albert(instance_of, albatross).
albert(size, 120).
ross(instance_of, albatross).
ross(size, 40).
% Frame animal: slot relative_size obtains its value by executing procedure
% relative_size
animal(relative_size, execute(relative_size(Object, Value), Object, Value)).
%% Inheritance
value(Frame, Slot, Value) :-
	Query =.. [Frame, Slot, Value], % =.. runtime evaluation
	call(Query), !.			% call(:Goal)
value(Frame, Slot, Value) :-
	parent(Frame, ParentFrame),
	value(ParentFrame, Slot, Value).
parent(Frame, ParentFrame) :-
	(Query =.. [Frame, a_kind_of, ParentFrame];
	 Query =.. [Frame, instance_of, ParentFrame]),
	call(Query).
%% Computing Value in a Slot
relative_size(Object, RelativeSize) :-
	value(Object, size, ObjSize),
	value(Object, instance_of, ObjClass),
	value(ObjClass, size, ClassSize),
	RelativeSize is ObjSize / ClassSize * 100.
value(Frame, Slot, Value) :-
	value(Frame, Frame, Slot, Value).
value(Frame, SuperFrame, Slot, Value) :-
	Query =.. [SuperFrame, Slot, Information],
	call(Query),
	process(Information, Frame, Value),!.
value(Frame, SuperFrame, Slot, Value) :-
	parent(SuperFrame, ParentSuperFrame),
	value(Frame, ParentSuperFrame, Slot, Value).
% process(Information, Frame, Value)
process(execute(Goal, Frame, Value), Frame, Value) :-
	call(Goal).
process(Value, _, Value).

%%%------------------------------------------------------------
%%% an exmaple knowledge base and reasoning
%%%
%%% Notes:
%%%
%%%   Inheritance "is a" method 1
%%% shark(shark). fish(shark). animal(X) :- fish(X).
%%%
%%%   Inheritance "is a" method 2:
%%% shark(shark). fish(X) :- shark(X). animal(X) :- fish(X).
%%%
%%%   Inheritance "is a" method 3:
%%% shark(is_a, fish). fish(is_a, animal). julia(instance_of, shark).
%%% 
%%%------------------------------------------------------------

% All animals have skin.
skin(X) :- animal(X).

% Fish is one kind of animal, birds are another type and mammals are a third
% type.
animal(X) :- fish(X); bird(X); mammal(X).

% Normally fish has gills and can swim, while birds have wings and can fly.
gills(X) :- fish(X).
swim(X) :- fish(X).
wings(X) :- bird(X).

% While birds and fish usually lies eggs, mammals do not.
egg(X) :- (fish(X), not(shark(X))); bird(X).
walking(X) :- (mammal(X), not(bat(X))); walkingbird(X).

% Although sharks are fish, they do not lay eggs - their children are born
% fully formed.  They are very dangerous.
fish(shark).
dangerous(shark).

% Salmon is another fish, and it is considered a delicacy.
fish(salmon).
delicacy(salmon).

% The canary is bird and it is yellow.
bird(canary).
color(yellow, canary).

% Ostrich is one kind of bird which is very tall but it can't fly, only walk.
walkingbird(ostrich).

% Mammals usually move by walking - as for instance the cow.
walking(X) :- cow(X).

% Cows give milk but are also used for food.
milk(cow).
food(X) :- cow(X); delicacy(X).

% Not all mammals move primarily by walking though, for instance the bat which
% flies.
fly(X) :- (bird(X), not(walkingbird(X))); bat(X).

% Canaries are yellow


% Ostriches are tall
size(tall, ostrich).

% Ascertain that a shark is a shark
shark(shark).
cow(cow).
bat(bat).

% Populating the animal kingdom
fish(trout).
% bird(canary).  in a KB, facts can be duplicated
bird(ostrich).
mammal(cow).
mammal(bat).

%%%------------------------------------------------------------
%%% Farmer, wolf, goat and cabbage
%%%------------------------------------------------------------
change(e,w).
change(w,e).
%
% Represent the character by the places in the list,
%     [farmer, wolf, goat, cabbage].
%
% Represent the state of the character by its value: e or w.
%
% using the second parameter 'Move' to help pattern matching, and contribute
% to the resulting list which represents the solution (moving steps).
%
% The possible value of 'Move' could be: wolf, goat, cabbage, nothing.
%
move([X,X,Goat,Cabbage], wolf, [Y,Y,Goat,Cabbage]) :- change(X,Y).
move([X,Wolf,X,Cabbage], goat, [Y,Wolf,Y,Cabbage]) :- change(X,Y).
move([X,Wolf,Goat,X], cabbage, [Y,Wolf,Goat,Y]) :- change(X,Y).
move([X,Wolf,Goat,C], nothing, [Y,Wolf,Goat,C]) :- change(X,Y).

% oneEq represents
%  at least one of the goat or the wolf is on the same bank as the farmer,
%  AND
%  at least one of the goat or cabbage is on the same side as the farmer.
oneEq(X,X,_).
oneEq(X,_,X).
safe([Man,Wolf,Goat,Cabbage]) :-
	oneEq(Man,Goat,Wolf),
	oneEq(Man,Goat,Cabbage).

solution([e,e,e,e], []) :- !.
solution(Config, [Move|Rest]) :-
	move(Config, Move, NextConfig),
	safe(NextConfig),
	solution(NextConfig, Rest).
% one of the solutions
% ?- solution([w,w,w,w], [goat,nothing,cabbage,goat,wolf,nothing,goat]).
% query result: 16 true and one false.
% ?- solution([w,w,w,w], X).
% query result: ERROR: Out of local stack, and lots of exceptions like this
%    Exception: (310,229) solution([e, w, e, w], _G4653352) ?
% Why?
