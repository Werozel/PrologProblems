% map - list of pairs

update([], pair(X, V), [pair(X, V)]).
update([pair(X, VOld)|T], pair(X, VNew), [pair(X, VNew)|T]) :- !.
update([X|T], E, [X|New]) :- update(T, E, New).

get([], K, Res) :- fail.
get([pair(K, V)|T], K, V) :- !.
get([X|T], K, [X|V]) :- get(T, K, V).

remove([], K, []).
remove([pair(K, _)|T], K, T) :- !.
remove([X|T], K, [X|New]) :- remove(T, K, New).
