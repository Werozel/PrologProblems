% map - list of pairs

iterate_map([pair(Key, Val)], Key, Val) :- !.
iterate_map([pair(Key, Val)|_], Key, Val).
iterate_map([_|T], Key, Val) :- iterate_map(T, Key, Val).

make_map([], []).
make_map([pair(K, V)|T], [pair(K, V)|NewMap]) :- 
    not(get(T, K, _)),
    make_map(T, NewMap),
    !.
make_map([pair(_, _)|T], NewMap) :- make_map(T, NewMap).

update([], pair(X, V), [pair(X, V)]) :- !.
update([pair(X, _)|T], pair(X, VNew), [pair(X, VNew)|T]) :- !.
update([X|T], E, [X|New]) :- update(T, E, New).

update_with_map(Map, [], Map) :- !.
update_with_map(Map, [X|T], OutMap) :-
    update(Map, X, UpdatedMap),
    update_with_map(UpdatedMap, T, OutMap).

add([], pair(X, V), [pair(X, V)]) :- !.
add([pair(X, VOld)|T], pair(X, _), [pair(X, VOld)|T]) :- !.
add([X|T], E, [X|New]) :- add(T, E, New).

add_map(Map, [], Map) :- !.
add_map(Map, [X|T], OutMap) :-
    add(Map, X, UpdatedMap),
    add_map(UpdatedMap, T, OutMap).

get([], _, []) :- fail.
get([pair(K, V)|_], K, V) :- !.
get([_|T], K, V) :- get(T, K, V).

remove([], _, []) :- fail.
remove([pair(K, _)|T], K, T) :- !.
remove([X|T], K, [X|New]) :- remove(T, K, New).

print_map([]).
print_map([pair(Key, Value)|T]) :-
    format('~a = ~w\n', [Key, Value]),
    print_map(T).

print_difference([]).
print_difference([pair(Key, pair(FirstValue, SecondValue))|T]) :-
    format('~a = ~w -> ~w\n', [Key, FirstValue, SecondValue]),
    print_difference(T),
    !.
print_difference([pair(Key, Value)|T]) :-
    format('~a = ~w\n', [Key, Value]),
    print_difference(T).
