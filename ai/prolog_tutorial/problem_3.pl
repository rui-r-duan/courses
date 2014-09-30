male(yingsheng-duan).
male(zhengpin-duan).
male(rui-duan).
male(grand-father-xu).
male(hanxiao-xu).
male(junfeng-kou).
male(ruxiong-xu).
female(weiya-xu).
female(huifen-liu).
female(grand-mother-duan).
female(mingxing-xu).
parent_of(grand-father-xu, mingxing-xu).
parent_of(huifen-liu, mingxing-xu).
parent_of(zhengpin-duan, yingsheng-duan).
parent_of(grand-mother-duan, yingsheng-duan).
parent_of(yingsheng-duan, rui-duan).
parent_of(mingxing-xu, rui-duan).

father(X,Y) :- male(X), parent_of(X,Y).
mother(X,Y) :- female(X), parent_of(X,Y).
son(X,Y) :- male(X), parent_of(Y,X).
daughter(X,Y) :- female(X), parent_of(Y,X).
grandfather(X,Y) :- male(X), parent_of(X,SomeOne), parent_of(SomeOne,Y).
% aunt
% uncle
% cousin
% ancestor
