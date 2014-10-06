%%% Inheritance and default reasoning
% Different types of animal
isa(canary,bird).
isa(ostrich,bird).
isa(bird,animal).
isa(opus,penguin).
isa(robin,bird).
isa(penguin,bird).
isa(fish,animal).
isa(tweety,canary).
hasprop(animal,cover,skin).
hasprop(fish,travel,swim).
hasprop(bird,travel,fly).
hasprop(bird,cover,feathers).
hasprop(ostrich,sound,sing).
hasprop(ostrich,travel,walk).
hasprop(ostrich,sound,sing).
hasprop(robin,color,red).
hasprop(penguin,color,brown).
hasprop(penguin,travel,walk).
hasprop(canary,color,yellow).
hasprop(canary,sound,sing).
hasprop(tweety,color,white).
% Inheritance
%%---------------------------------------------------
%% Added by me
hasproperty(Object,Property,Value) :-
	isa(Object,Parent),
	hasprop(Object,Property,Value),!.
%%---------------------------------------------------
hasproperty(Object,Property,Value) :- hasprop(Object,Property,Value).
hasproperty(Object,Property,Value) :-
	isa(Object,Parent),
	hasproperty(Parent,Property,Value).