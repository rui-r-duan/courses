worker(bill).
worker(smitt).
worker(fred).
worker(dany).
worker(john).
car(bmw).
car(mazda).
car(audi).
owner(fred,mazda).
owner(dany,bmw).
owner(john,audi).

hascar(X) :- owner(X,_).
nocar(X) :- worker(X), not(hascar(X)).