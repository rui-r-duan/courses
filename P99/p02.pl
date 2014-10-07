%%% Find the last but one element of a list.
last_but_one(X, [X,_]).
last_but_one(X, [_,Y|Ys]) :- last_but_one(X, [Y|Ys]).

%%%------------------------------------------------------------
%%% Note:
%%%------------------------------------------------------------

% [_|Y|Ys] result in syntax error

% test1(X, []). => false.
% test1(X, [a]). => false.
% test1(X, [a,b]). => X = a.
% test1(X, [a,b,c]). => false.
test1(X, [X,_]).

% test2(X, []). => false.
% test2(X, [a]). => X = a.
% test2(X, [a,b]). => X = a.
% test2(X, [a,b,c]). => X = a.
test2(X, [X|_]).

% test3(X, []). => false.
% test3(X, [a]). => false.
% test3(X, [a,b]). => X = b.
% test3(X, [a,b,c]). => false.
test3(X, [_,X]).

% test4(X, []). => false.
% test4(X, [a]). => X = [].
% test4(X, [a,b]). => X = [b].
% test4(X, [a,b,c]). => X = [b, c].
test4(X, [_|X]).

% test5(X, []). => false.
% test5(X, [a]). => X = a.
% test5(X, [a,b]). => false.
% test5(X, [a,b,c]). => false.
test5(X, [X]).
