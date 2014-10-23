%-------------------------------------------------------------------------------
%
% author: Rui Duan (0561866)
%
% Key idea to rule out who has an unacceptable excuse:
%
%    \+ has_excuse(...) means cannot be proved to be true, so it is false, which
%        means "does not have excuse" in Prolog's Database semantics.
%
%    has_excuse(...) is true only if the provider of the excuse is trustworthy.
%        In this KB, only sam is said to be untrustworthy, the other persons are
%        not mentioned, which means the other persons cannot be proved to be
%        untrustworthy, which means they "are trustworthy" in Prolog's Database
%        semantics.
%
%-------------------------------------------------------------------------------

%% Facts
excuse(john, friday, zaki).	% john has an excuse for friday given by zaki
excuse(stuart, friday, zaki).	% stuart has an excuse for friday given by zaki
excuse(adam, friday, john).	% adam has an excuse for friday given by john
excuse(sam, monday, john).	% sam has an excuse for monday given by john
untrustworthy(sam).		% sam is not a trustworthy person
want_revenge(stuart).		% stuart wats to take revenge on susan
want_revenge(john).		% john wants to take revenge on susan
heir_of(zaki, susan).		% zaki is the heir of susan's wealth
heir_of(susan, adam).		% susan is the heir of adam's wealth
owe_money_to(adam, susan).	% adam owes money to susan
owe_money_to(john, susan).	% john owes money to susan
see_committing_crime(susan, sam). % susan has seen sam committing a crime
own(john, gun).			 % john owns a gun
own(adam, gun).			 % adam owns a gun
own(sam, gun).			 % sam owns a gun

%% Rules
murderer(X) :-
	has_motive(X),
	own(X, gun),
	\+ has_excuse(X, friday, _). % no excuse on friday

% IF Y cannot be proved to be an untrustworthy person, <=> Y is trustworthy
% THEN the excuse is accepted.
has_excuse(X, D, Y) :-
	excuse(X, D, Y),
	\+ untrustworthy(Y).

has_motive(X) :- has_interest(X).
has_motive(X) :- want_revenge(X).

has_interest(X) :- heir_of(X, susan).
has_interest(X) :- owe_money_to(X, susan).
has_interest(X) :- see_committing_crime(susan, X).

%%----------------------------------------------------------------------
% Query: Who killed susan?
%%----------------------------------------------------------------------
% -? murderer(X).
% X = sam ;
% false.

%%----------------------------------------------------------------------
% Unit Test 1: Can we prove that sam has no acceptable excuse?
%%----------------------------------------------------------------------
%
% sam is ruled out, that is, sam has no acceptable excuse.
%
% -? has_excuse(X,D,Y).
% X = john ;
% X = stuart ;
% X = adam ;
% false.

%%----------------------------------------------------------------------
% Unit Test 2: Who does not have excuse on friday?
%               They should be sam, zaki and adam.
%%----------------------------------------------------------------------
%
% -? \+ has_excuse(john,friday,_).
% false.
%
% -? \+ has_excuse(stuart,friday,_).
% false.
%
% -? \+ has_excuse(sam,friday,_).
% true.
%
% -? \+ has_excuse(zaki,friday,_).
% true.
%
% -? \+ has_excuse(adam,friday,_).
% false.
