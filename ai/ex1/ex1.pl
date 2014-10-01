%%% Exercise #1: Structures in Prolog
%%% Author: Rui Duan (0561866)
%%% Date: September 30, 2014

%%% 1(a)
extractout(X, [X|R], R).
extractout(X, [H|R], [H|S]) :- extractout(X, R, S).

%%% To insert 3 into [1,2], do the following query:
%%%    extractout(3, L, [1,2]).

%%% 1(b)
permutation([X|Y], Z) :- permutation(Y, W), extractout(X, Z, W).
permutation([], []).

%%% 1(c)
sub(X, Y, [H|T], [H|R]) :- H \= X, sub(X, Y, T, R).
sub(X, Y, [X|T], [Y|R]) :- sub(X, Y, T, R).
sub(X, Y, [], []).

%%% 2(a)
% test data:
%   t(t(t(nil,1,nil), 2, t(nil,3,nil)), 4, t(t(nil,5,nil), 6, t(nil,7,nil)))
less(X, t(L, K, R)) :-
	less(X, K),
	less(X, L),
	less(X, R), !.
less(t(L, K, R), X) :-
	less(K, X),
	less(L, X),
	less(R, X), !.
less(nil, X) :- !.
less(X, nil) :- !.
less(X, Y) :- X < Y, !.
orderedT(t(L, K, R)) :-
	less(L, K),
	less(K, R).
