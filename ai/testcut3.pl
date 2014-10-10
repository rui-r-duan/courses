a(X) :- b(X), !, c(X).
b(1).
b(2).
b(3).
 
c(2).

% query a(2). => true
% query a(Q). => false