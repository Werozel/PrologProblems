mySubstityde(empty, _, _, empty).
mySubstityde(tree(L, V, R), V, W, tree(L1, W, R1)) :- mySubstityde(L, V, W, L1), mySubstityde(R, V, W, R1).
mySubstityde(tree(L, X, R), V, W, tree(L1, X, R1)) :- mySubstityde(L, V, W, L1), mySubstityde(R, V, W, R1), dif(X, V).

myMember(E, [E | _]).
myMember(E, [X | Xs]) :- dif(E, X), myMember(E, Xs).

myAppend([], V, [ V ]).
myAppend([X | Xs], V, [X | V1]) :- myAppend(Xs, V, V1). 

mySublist(L1, L2) :- 
    append(X, Y, L2),
    append(Z, L1, X),
    dif(L1, []).

delete_one(E, [E | T], T).
delete_one(E, [_ | T], [X | T1]) :- delete_one(E, T, T1).

myLength([], 0).
myLength([X | T], N1) :- 
    myLength(T, N), 
    N1 is N + 1.

myNumber(E, 1, [E | _]).
myNumber(E, N1, [_ | T]) :-
    myNumber(E, N, T),
    N1 is N + 1.
