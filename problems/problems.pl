% №9 Сортировка выборкой (i, i), (i, o)
my_sort([], []).
my_sort(L1, [M|L2]) :- 
    min_list(L1, M), 
    delete_one(L1, M, R), 
    my_sort(R, L2).

delete_one([], _, []).
delete_one([X|T], X, T) :- !.
delete_one([X|T], E, [X|R]) :- delete_one(T, E, R).


% №10 (i, i) (i, o)

my_subset(L1, L2) :- my_subset_tmp(L1, L2, L1).

my_subset_tmp([], L2, []).
my_subset_tmp([X|T], L2, [X|Res]) :-
    member(X, L2),
    delete_one(L2, X, NewL2),
    my_subset_tmp(T, NewL2, Res),
    \+ member(X, Res).


% №11 (i, i, i) (i, i, o)


my_union(M1, [], M1).
my_union(M1, [X|T2], R) :- 
    member(X, M1), 
    delete(X, M1, NewM1),
    my_union(T2, NewM1, R).
my_union(M1, [X|T2], [X|R]) :- my_union(T2, M1, R).

% my_union(M1, [], M1) :- !.
% my_union([], M2, M2).
% my_union([X|T1], M2, [X|R]) :-
%     member(X, M2),
%     delete(M2, X, NewM2),
%     my_union(T1, NewM2, R).
% my_union(M1, [X|T2], [X|R]) :- 
%     member(X, M1), 
%     delete(T2, M1, NewM1),
%     my_union(T2, NewM1, R).
% my_union([X|T1], M2, [X|R]) :-
%     \+ member(X, M2),
%     my_union(T1, M2, R).
% my_union(M1, [X|T2], [X|R]) :- 
%     \+ member(X, M1),
%     my_union(T2, M1, R).


% Примеры для графов
% 1 (из методички)
edge(e, d, 9).
edge(a, c, 8).
edge(a, b, 3).
edge(d, c, 12).
edge(b, d, 0).


% 2 
% edge(a, c, 10).
% edge(a, b, 8).
% edge(b, c, 8).
% edge(a, d, 3).
% edge(d, e, 4).
% edge(e, c, 3).

% 3 (несвязный)
% edge(a, b, 2).
% edge(b, c, 8).
% edge(c, d, 7).
% edge(b, d, 0).
% edge(a, g, 2).
% edge(g, d ,0).

% edge(e, f, 3).

set_of_nodes(R) :- 
    findall(X, edge(X, _, _), L1), 
    findall(Y, edge(_, Y, _), L2), 
    append(L1, L2, L), list_to_set(L, R).


% №16 (i, i, i), (i, i, o), (i, o, i), (o, i, i), (o, o, i), (o, i, o), (i, o, o), (o, o, o)
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


% №17 (i, i, i), (i, i, o)
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

find_min_pair([], pair([], 0)).
find_min_pair([X|T], E) :- 
    findall(R, find_min_pair_tmp(T, R, X), Rall), 
    list_to_set(Rall, Rset),
    member(E, Rset).

find_min_pair_tmp([], CurrMin, CurrMin).
find_min_pair_tmp([pair(List, CurrMinValue)|T], R, pair(CurrMinList, CurrMinValue)) :- find_min_pair_tmp(T, R, pair(List, CurrMinValue)).
find_min_pair_tmp([pair(List, CurrMinValue)|T], R, pair(CurrMinList, CurrMinValue)) :- find_min_pair_tmp(T, R, pair(CurrMinList, CurrMinValue)).
find_min_pair_tmp([pair(List, Value)|T], R, pair(CurrMinList, CurrMinValue)) :- 
    Value < CurrMinValue, 
    find_min_pair_tmp(T, R, pair(List, Value)).
find_min_pair_tmp([pair(List, Value)|T], R, pair(CurrMinList, CurrMinValue)) :- 
    Value > CurrMinValue, 
    find_min_pair_tmp(T, R, pair(CurrMinList, CurrMinValue)).


% №18  (i, i, o), (o, i, i)
short_path(E, E, []).
short_path(E1, E2, X) :- 
    findall(R, path(E1, E2, R), Rall),
    list_to_set(Rall, Set),
    zip_with_length(Set, Zipped),
    find_min_pair(Zipped, pair(X, _)).

zip_with_length([], []).
zip_with_length([X|T], [pair(X, Length)|Res]) :- 
    length(X, Length), 
    zip_with_length(T, Res).


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
