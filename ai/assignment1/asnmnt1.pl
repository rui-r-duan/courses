%%% 1
and(0,0,0).
and(0,1,0).
and(1,0,0).
and(1,1,1).
or(0,0,0).
or(0,1,1).
or(1,0,1).
or(1,1,1).
not(1,0).
not(0,1).
xor(A,B,Out) :-
	not(B,NB), and(A,NB,X),
	not(A,NA), and(NA,B,Y),
	or(X,Y,Out).
half_adder(A,B,Carry,Sum) :-
	and(A,B,Carry),
	xor(A,B,Sum).
full_adder(A,B,CarryIn,CarryOut,Sum) :-
	half_adder(A,B,C1,S1),
	half_adder(CarryIn,S1,C2,Sum),
	or(C1,C2,CarryOut).

%%% 2
employee(mcardon,1,5).
employee(treeman,2,3).
employee(chapman,1,2).
employee(claessen,4,1).
employee(petersen,5,8).
employee(cohn,1,7).
employee(duffy,1,9).
department(1,board).
department(2,human_resources).
department(3,production).
department(4,technical_services).
department(5,administration).
salary(1,1000).
salary(2,1500).
salary(3,2000).
salary(4,2500).
salary(5,3000).
salary(6,3500).
salary(7,4000).
salary(8,4500).
salary(9,5000).

% (1) Design a Prolog query to select those employees who earn between $3,000
% and $4,500 per month;
% also select all employees who are in salary scale 1, and working in
% department 1.
earn_between(Employee) :-
	employee(Employee,_,Scale),
	salary(Scale,Salary),
	Salary >= 3000,
	Salary =< 4500,
	write(Employee),nl,
	fail.
select_employee(Employee) :-
	employee(Employee,DepartmentNum,Scale),
	Scale == 1,
	DepartmentNum == 1,
	write(Employee),nl,
	fail.

% (2) implement the projection operator
project_name_scale(Name,Scale) :-
	employee(Name,_,Scale),
	format("~w ~w",[Name,Scale]),nl,
	fail.

% (3)
join_employee_department([]) :-
	employee(Name,DepNum,Scale),
	department(DepNum,DepName),
	format("~w ~w ~w ~w", [Name,DepNum,DepName,Scale]),nl,
	fail.

%%% 3
is_male(chris).
is_male(jim).
is_male(rob).
is_male(joe).
is_male(tom).
is_male(steve).
is_male(dan).
is_male(mike).
is_female(lucy).
is_female(jill).
is_female(ann).
is_female(nan).
is_female(sue).
is_female(sara).
is_female(kate).
is_parent(chris,jill).
is_parent(lucy,jill).
is_parent(jill,ann).
is_parent(jill,joe).
is_parent(jim,rob).
is_parent(rob,ann).
is_parent(rob,joe).
is_parent(nan,rob).
is_parent(nan,sue).
is_parent(tom,sue).
is_parent(sue,sara).
is_parent(sue,mike).
is_parent(steve,dan).
is_parent(dan,sara).
is_parent(dan,mike).
is_parent(kate,dan).

is_father(X,Y) :- is_male(X), is_parent(X,Y).
is_mother(X,Y) :- is_female(X), is_parent(X,Y).

% An ancestor or forebear is a parent or (recursively) the parent of an
% ancestor (i.e., a grandparent, great-grandparent, great-great-grandparent,
% and so forth). Ancestor is "any person from whom one is descended".
ancester(X,Y) :- is_parent(X,Y).
ancester(X,Y) :- is_parent(X,Z), ancester(Z,Y).

is_sibling(X,Y) :- is_parent(P,X), is_parent(P,Y), not(X=Y).

% first cousin
is_cousin(X,Y) :-
	is_parent(A,X),
	is_parent(B,Y),
	is_sibling(A,B).

% http://en.wikipedia.org/wiki/Cousin
%
% A cousin is a relative with whom a person shares one or more common
% ancestors. In the general sense, cousins are two or more generations away
% from any common ancestor, thus distinguishing a cousin from an ancestor,
% descendant, sibling, aunt, uncle, niece, or nephew.
is_general_cousin(X,Y) :-
	ancester(A,X),
	ancester(A,Y),
	\+(is_parent(A,X)), \+(is_parent(A,Y)), not(X=Y).

% not(X=Y) means cannot be unified.
is_brother(X,Y) :- is_male(X), is_parent(P,X), is_parent(P,Y), not(X=Y).

%%% 4
% box(Number,Color,Size)
box(1,black,4).
box(2,black,1).
box(3,white,1).
box(4,black,3).
box(5,white,4).
owner(dina).
owner(william).
owner(charlie).
owner(daniel).
owner(sam).

have(Owner,BoxNum) :- owner(Owner), box(BoxNum,_,_).

find_owner(dina,Box1,william,Box2,charlie,Box3,daniel,Box4,sam,Box5) :-
				% rule 5: each one owns a unique box
	have(dina,Box1), have(william,Box2), have(charlie,Box3),
	have(daniel,Box4),have(sam,Box5),
	Box1 \= Box2, Box1 \= Box3, Box1 \= Box4, Box1 \= Box5,
	Box2 \= Box3, Box2 \= Box4, Box2 \= Box5, Box3 \= Box4,
	Box3 \= Box5, Box4 \= Box5,
				% rule 1: dina's and william's are of same color
	box(Box1,C1,_), box(Box2,C1,_),
				% rule 2: daniel's and sam's are of same color
	box(Box4,C2,_), box(Box5,C2,_),
				% rule 3: charlie's and daniel's are same size
	box(Box3,_,S1), box(Box4,_,S1),
				% rule 4: sam's is smaller than william's
	box(Box5,_,Size5), box(Box2,_,Size2),
	Size5 < Size2.

%%% 5
%%% Reference: Ninety-Nine Prolog Problems
%%% I studied every predicate in the solution, the !/0 predicate,
%%% and made some comments.

% A purely recursive syntax is:
%
% <identifier> ::= <letter> <rest>
%
% <rest> ::=  | <optional_underscore> <letter_or_digit> <rest>
%
% <optional_underscore> ::=  | '_'
%
% <letter_or_digit> ::= <letter> | <digit>

% identifier(Str) :- Str is a legal Ada identifier

% String is an atom.
% Convert string to list, and judge whether it is a valid identifier.
% In Prolog, an atom is one of
%     a string, like 'abc_d53', but not "abc_d53" in (Prolog version < 7)
%     a symbol
%     the empty list []
%     strings of special characters, like <--->, ..., ===>.
identifier(S) :- atom(S), atom_chars(S,L), identifier(L).

% <identifier> ::= <letter> <rest>
identifier([X|L]) :- char_type(X,alpha), rest(L).

% <rest> ::=  | <optional_underscore> <letter_or_digit> <rest>
rest([]) :- !.					   % prune rest([])
rest(['_',X|L]) :- !, letter_or_digit(X), rest(L). % prune rest(['_',X|L])
rest([X|L]) :- letter_or_digit(X), rest(L).

% <letter_or_digit> ::= <letter> | <digit>
letter_or_digit(X) :- char_type(X,alpha), !. %prune char_type(X,alpha) and
				% letter_or_digit(X)
letter_or_digit(X) :- char_type(X,digit).
