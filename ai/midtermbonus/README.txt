Two versions of the solution are provided.

murder_mystery.pl solves the problem strictly according to the specification.

murder_mystery_variation.pl makes two modifications to the specification and
the interpretation of it, which makes the program a little more challenging and
interesting.

In particular, the variation makes the rule
        untrustworthy(sam)
more useful in this program.

----------
VARIATION
----------

1. The day of sam's excuse is changed from Monday to Friday.

excuse(sam, monday, john).

is changed to

excuse(sam, friday, john).

2. Added one recedent to has_excuse(...) which requires the person who has
   excuse to be a trustworthy person.

has_excuse(X, D, Y) :-
	excuse(X, D, Y),
	\+ untrustworthy(Y).

is changed to

has_excuse(X, D, Y) :-
	excuse(X, D, Y),
	\+ untrustworthy(X),
	\+ untrustworthy(Y).
