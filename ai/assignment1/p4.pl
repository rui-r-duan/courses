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
