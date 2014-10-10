a(X) :- b(X), !, c(X).		% prune b(X) and a(X)
a(X) :- d(X).

b(1).
b(4).

c(3).

d(4).

% query a(4). => false.    a(X) is pruned
% query a(X). => false.    b(X) is pruned