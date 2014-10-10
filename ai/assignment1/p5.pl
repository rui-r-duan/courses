%%% 5
%%% Reference: Ninety-Nine Prolog Problems

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
