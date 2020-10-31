
% №9
delete_one([], _, []).
delete_one([X|T], X, T) :- !.
delete_one([X|T], E, [X|R]) :- delete_one(T, E, R).

my_sort([], []).
my_sort(L1, [M|L2]) :- 
    min_list(L1, M), 
    delete_one(L1, M, R), 
    my_sort(R, L2).


% №10
my_subset([], L2).
my_subset([X|T], L2) :- 
    member(X, L2), 
    my_subset(T, L2).


% №11
my_union(M1, [], M1).
my_union(M1, [X|T2], R) :- 
    member(X, M1), 
    my_union(T2, M1, R), !.
my_union(M1, [X|T2], [X|R]) :- my_union(T2, M1, R).


% Примеры для графов
% 1 (из методички)
edge(e, d, 9).
edge(a, c, 8).
edge(a, b, 3).
edge(c, d, 12).
edge(b, d, 0).

set_of_nodes(R) :- 
    findall(X, edge(X, _, _), L1), 
    findall(Y, edge(_, Y, _), L2), 
    append(L1, L2, L), list_to_set(L, R).


% №16
path(E, E, []).
path(E1, E2, L) :- path_tmp(E1, E2, L, [E1]).

path_tmp(E1, E2, [], M) :- 
    edge(E1, E2, _), 
    \+ member(E2, M).
path_tmp(E1, E2, [], M) :- 
    edge(E2, E1, _), 
    \+ member(E2, M).
path_tmp(E1, E2, [X|L], M) :- 
    edge(E1, X, _), 
    \+ member(X, M), 
    path_tmp(X, E2, L, [X|M]).
path_tmp(E1, E2, [X|L], M) :- 
    edge(X, E1, _), 
    \+ member(X, M), 
    path_tmp(X, E2, L, [X|M]).


% №17
find_min_pair([], pair([], 0)).
find_min_pair([X|T], R) :- find_min_pair_tmp(T, R, X).

find_min_pair_tmp([], CurrMin, CurrMin).
find_min_pair_tmp([pair(List, CurrMinValue)|T], R, pair(CurrMinList, CurrMinValue)) :- find_min_pair_tmp(T, R, pair(List, CurrMinValue)).
find_min_pair_tmp([pair(List, CurrMinValue)|T], R, pair(CurrMinList, CurrMinValue)) :- find_min_pair_tmp(T, R, pair(CurrMinList, CurrMinValue)).
find_min_pair_tmp([pair(List, Value)|T], R, pair(CurrMinList, CurrMinValue)) :- 
    Value < CurrMinValue, 
    find_min_pair_tmp(T, R, pair(List, Value)).
find_min_pair_tmp([pair(List, Value)|T], R, pair(CurrMinList, CurrMinValue)) :- 
    Value > CurrMinValue, 
    find_min_pair_tmp(T, R, pair(CurrMinList, CurrMinValue)).

min_path(E, E, []) :- !.
min_path(E1, E2, R) :- 
    findall(L, min_path_tmp(E1, E2, L, [E1], [], 0), Res), 
    find_min_pair(Res, pair(R, _)).

min_path_tmp(E1, E2, pair(CurrPath, NewCurrValue), M, CurrPath, CurrValue) :- 
    edge(E1, E2, V), 
    \+ member(E2, M),
     NewCurrValue is CurrValue + V.
min_path_tmp(E1, E2, pair(CurrPath, NewCurrValue), M, CurrPath, CurrValue) :- 
    edge(E2, E1, V), 
    \+ member(E2, M), 
    NewCurrValue is CurrValue + V.
min_path_tmp(E1, E2, L, M, CurrPath, CurrValue) :- 
    edge(E1, X, V), 
    \+ member(X, M), 
    NewCurrValue is CurrValue + V, 
    min_path_tmp(X, E2, L, [X|M], [X|CurrPath], NewCurrValue).
min_path_tmp(E1, E2, L, M, CurrPath, CurrValue) :- 
    edge(X, E1, V), 
    \+ member(X, M), 
    NewCurrValue is CurrValue + V, 
    min_path_tmp(X, E2, L, [X|M], [X|CurrPath], NewCurrValue).


% №18
short_path(E, E, []).
short_path(E1, E2, L) :- short_path_tmp(E1, E2, L, [E1]).

short_path_tmp(E1, E2, [], M) :- 
    edge(E1, E2, _), 
    \+ member(E2, M), 
    !.
short_path_tmp(E1, E2, [], M) :- 
    edge(E2, E1, _), 
    \+ member(E2, M), 
    !.
short_path_tmp(E1, E2, [X|L], M) :- 
    edge(E1, X, _), 
    \+ member(X, M), 
    short_path_tmp(X, E2, L, [X|M]).
short_path_tmp(E1, E2, [X|L], M) :- 
    edge(X, E1, _), 
    \+ member(X, M), 
    short_path_tmp(X, E2, L, [X|M]).


% №19
cyclic :- 
    once(edge(X, Y, _)), 
    cyclic_tmp(Y, X, [X]).

cyclic_tmp(Curr, From, WasTo) :- 
    edge(Curr, X, _), 
    X \= From, 
    member(X, WasTo), 
    !.
cyclic_tmp(Curr, From, WasTo) :- 
    edge(X, Curr, _),
    X \= From, 
    member(X, WasTo), 
    !.
cyclic_tmp(Curr, From, WasTo) :- 
    edge(X, Curr, _), 
    X \= From, 
    \+ member(X, WasTo), 
    cyclic_tmp(X, Curr, [Curr|WasTo]), 
    !.
cyclic_tmp(Curr, From, WasTo) :- 
    edge(Curr, X, _), 
    X \= From, 
    \+ member(X, WasTo), 
    cyclic_tmp(X, Curr, [Curr|WasTo]), 
    !.


% №20
is_connected :- 
    set_of_nodes(Nodes), 
    is_connected_tmp(Nodes, Nodes).

is_connected_tmp([], _) :- !.
is_connected_tmp([X|T], Nodes) :- 
    path_to_any(X, Nodes), 
    is_connected_tmp(T, Nodes).

path_to_any(_, []) :- !.
path_to_any(From, [X|T]) :- 
    once(path(From, X, _)), 
    path_to_any(From, T).