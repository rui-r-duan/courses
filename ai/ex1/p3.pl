% Allowed Colors
color(red).
color(blue).
color(green).
color(yellow).

% Geographical data for South America
country(antilles). country(argentina).
country(bolivia). country(brazil).
country(columbia). country(chile).
country(ecuador). country(french_guiana).
country(guyana). country(paraguay).
country(peru). country(surinam).
country(uruguay). country(venezuela).
beside(antilles,venezuela). beside(argentina,bolivia).
beside(argentina,brazil). beside(argentina,chile).
beside(argentina,paraguay). beside(argentina,uruguay).
beside(bolivia,brazil). beside(bolivia,chile).
beside(bolivia,paraguay). beside(bolivia,peru).
beside(brazil,columbia). beside(brazil,french_guiana).
beside(brazil,guyana). beside(brazil,paraguay).
beside(brazil,peru). beside(brazil,surinam).
beside(brazil,uruguay). beside(brazil,venezuela).
beside(chile,peru). beside(columbia,ecuador).
beside(columbia,peru). beside(columbia,venezuela).
beside(ecuador,peru). beside(french_guiana,surinam).
beside(guyana,surinam). beside(guyana,venezuela).

adjacent(X, Y) :- beside(X, Y).
adjacent(X, Y) :- beside(Y, X).

diffcolor(X, Y) :- color(X), color(Y), X =\= Y.

pair(Country, Color) :- country(Country), color(Color).

adjacent_diffcolor(A, AColor, B, BColor) :-
	adjacent(A, B),
	diffcolor(AColor, BColor).

color_adjacent(X, [pair(X,XC)|pair(Y,YC)]) :-
	adjacent_diffcolor(X, XC, Y, YC).

color_map([],[]).
color_map([FirstCountry | RestCountries], [pair(FirstCountry, C) | Result]) :-
	adjacent_diffcolor(FirstCountry, C, Neighbor, C2),
	color_map(RestCountries, Result).

gen_country_list(X) :- country(X).
gen_country_list([]).
