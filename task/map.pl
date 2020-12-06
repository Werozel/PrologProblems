% map - list of pairs

update([], pair(X, V), [pair(X, V)]).
update([pair(X, _)|T], pair(X, VNew), [pair(X, VNew)|T]) :- !.
update([X|T], E, [X|New]) :- update(T, E, New).

add([], pair(X, V), [pair(X, V)]).
add([pair(X, VOld)|T], pair(X, _), [pair(X, VOld)|T]) :- !.
add([X|T], E, [X|New]) :- add(T, E, New).

get([], _, []) :- fail.
get([pair(K, V)|_], K, V) :- !.
get([X|T], K, V) :- get(T, K, V).

remove([], _, []) :- fail.
remove([pair(K, _)|T], K, T) :- !.
remove([X|T], K, [X|New]) :- remove(T, K, New).
