% :- [facts].
:- ['database.txt'].
:- [map].

% Получение всех аттрибутов в системе
get_all_attributes(Attributes) :- 
    findall(Attribute, attribute(_, Attribute, _), AttributesList),
    list_to_set(AttributesList, Attributes).

% Получение всех аттрибутов для спорта (i, o, o) или значения для спорта и его аттрибута (i, i, o).
get_attributes(Sport, Attribute, Value) :- 
    get_attribute_map(Sport, [], Map),
    iterate_map(Map, Attribute, Value).

% Получение списка всех уникальных аттрибутов для спорта
get_attribute_map(Sport, _, _) :-
    \+ inherit(_, Sport),
    !.
get_attribute_map(Sport, LastMap, CombinedMaps) :- 
    findall(Map, get_attribute_helper(Sport, LastMap, Map), ListOfMaps),
    flatten(ListOfMaps, ResList),
    make_map(ResList, ResMap),
    findall(pair(X, Y), attribute(Sport, X, Y), AttributesList), 
    make_map(AttributesList, AttributesMap), 
    update_with_map(ResMap, AttributesMap, CombinedMaps).

get_attribute_helper(Sport, InMap, OutMap) :-
    inherit(Parent, Sport),
    get_attribute_map(Parent, InMap, OutMap). 

% Получение конкретного аттрибута для спорта
get_attribute_value(Sport, Attribute, Res) :- 
    get_attributes(Sport, Attribute, Res), 
    !.

% Получение всех видов спорта
get_sports(SportsSet) :- 
    findall(X, instance(X), Sports), 
    list_to_set(Sports, SportsSet).

print_list([]).
print_list([X|T]) :-
    writeln(X),
    print_list(T).

% Получение различия в конкретном атрибуте
get_attribute_diff(Sport, Sport, _, "No difference") :- !.
get_attribute_diff(FirstSport, SecondSport, Attribute, none) :- 
    get_attributes(FirstSport, Attribute, Value),
    get_attributes(SecondSport, Attribute, Value).
get_attribute_diff(FirstSport, SecondSport, Attribute, pair(FirstValue, SecondValue)) :-
    get_attributes(FirstSport, Attribute, FirstValue),
    get_attributes(SecondSport, Attribute, SecondValue),
    dif(FirstValue, SecondValue).
get_attribute_diff(FirstSport, SecondSport, Attribute, pair(FirstValue, none)) :-
    get_attributes(FirstSport, Attribute, FirstValue),
    \+ get_attributes(SecondSport, Attribute, _).
get_attribute_diff(FirstSport, SecondSport, Attribute, pair(none, SecondValue)) :-
    get_attributes(SecondSport, Attribute, SecondValue),
    \+ get_attributes(FirstSport, Attribute, _).

print_attribute_diff(FirstSport, SecondSport) :-
    findall(pair(Attribute, Difference), get_attribute_diff(FirstSport, SecondSport, Attribute, Difference), ResultList),
    make_map(ResultList, ResultMap),
    print_difference(ResultMap).

print_difference([]).
print_difference([pair(Key, pair(FirstValue, SecondValue))|T]) :-
    format('~a = ~w -> ~w\n', [Key, FirstValue, SecondValue]),
    print_difference(T),
    !.
print_difference([pair(Key, Value)|T]) :-
    format('~a = ~w\n', [Key, Value]),
    print_difference(T).

% Редактировать аттрибуты спорта
edit_sport_attribute(Sport, _, _) :-
    \+ inherit(_, Sport),
    writeln("Такого спорта не существует"),
    !.
edit_sport_attribute(Sport, Attribute, Value) :- 
    attribute(Sport, Attribute, _),
    retract(attribute(Sport, Attribute, _)),
    assert(attribute(Sport, Attribute, Value)),
    !.
edit_sport_attribute(Sport, Attribute, Value) :-
    assert(attribute(Sport, Attribute, Value)).

delete_sport_attribute(Sport, Attribute) :-
    attribute(Sport, Attribute, _),
    retract(attribute(Sport, Attribute, _)).

manage_edit(Sport) :- 
    writeln("1 - Добавить/изменить значение аттрибута"),
    writeln("2 - Удалить аттрибут"),
    writeln("q - Вернуться"),
    read(N),
    manage_edit(Sport, N).
manage_edit(Sport, 1) :- 
    write("Введите аттрибут: "),
    read(Attribute),
    write("Введите значение: "),
    read(Value),
    edit_sport_attribute(Sport, Attribute, Value),
    manage_edit(Sport).
manage_edit(Sport, 2) :-
    write("Введите аттрибут: "),
    read(Attribute),
    delete_sport_attribute(Sport, Attribute),
    manage_edit(Sport).
manage_edit(_, q) :- !.
manage_edit(Sport, _) :- manage_edit(Sport).

% Удаление спорта
dalete_sport(Sport) :-
    not(instance(Sport)),
    writeln("Такого спорта не существует"),
    !.
delete_sport(Sport) :- retract(attribute(Sport, _, _)).
delete_sport(Sport) :- retract(inherit(_, Sport)).
delete_sport(Sport) :- retract(instance(Sport)).

% Добавление нового спорта
add_sport(Sport) :- 
    assert(instance(Sport)).

add_inherit(Class, Sport) :-
    inherit(Class, Sport),
    !.
add_inherit(Class, Sport) :- 
    assert(inherit(Class, Sport)).

manage_sport_inheritance(Sport) :- 
    \+ instance(Sport),
    writeln("Такого спорта не существует"),
    !.
manage_sport_inheritance(Sport) :-
    writeln("1 - Добавить класс наследования для спорта"),
    writeln("2 - Вывести все классы наследования для спорта"),
    writeln("q - Вернуться"),
    read(N),
    manage_sport_inheritance(Sport, N).
manage_sport_inheritance(_, q) :- !.
manage_sport_inheritance(Sport, 1) :-
    write("Введите класс: "),
    read(Class),
    add_inherit(Class, Sport),
    manage_sport_inheritance(Sport).
manage_sport_inheritance(Sport, 2) :-
    findall(X, class(X), Classes),
    print_list(Classes),
    manage_sport_inheritance(Sport).
manage_sport_inheritance(Sport, _) :- manage_sport_inheritance(Sport).

% Интеракция с пользователем
start :- 
    writeln("1 - Найти все аттрибуты определенного вида спорта"),
    writeln("2 - Найти значение аттрибута для определенного вида спорта"),
    writeln("3 - Найти различия между двумя видами спорта"),
    writeln("4 - Найти все зарегестрированные виды спорта"),
    writeln("5 - Добавить новый вид спорта"),
    writeln("6 - Удалить существующий вид спорта"),
    writeln("7 - Редактировать существующий вид спорта"),
    writeln("q - Выйти"),
    read(N),
    execute(N). 

execute(1) :- 
    write("Введите название спорта: "),
    read(Sport),
    findall(
        pair(Attribute, Value), 
        get_attributes(Sport, Attribute, Value), 
        Map
    ),
    print_map(Map),
    start.
execute(2) :- 
    write("Введите название спорта: "),
    read(Sport),
    write("Введите название аттрибута: "),
    read(Attribute),
    get_attributes(Sport, Attribute, Value),
    writeln(Value),
    start.    
execute(3) :-
    write("Введите название первого спорта: "),
    read(FirstSport),
    write("Введите название второго спорта: "),
    read(SecondSport),
    print_attribute_diff(FirstSport, SecondSport),
    start.
execute(4) :-
    get_sports(Sports),
    print_list(Sports),
    start.
execute(5) :-
    write("Введите новый спорт: "),
    read(Sport),
    add_sport(Sport),
    manage_sport_inheritance(Sport),
    start.
execute(6) :-
    write("Введите спорт: "),
    read(Sport),
    delete_sport(Sport),
    start.
execute(7) :-
    write("Введите спорт: "),
    read(Sport),
    manage_edit(Sport),
    start.
execute(q) :- !.
execute(_) :- start.

% Сохранение в базу данных
save_all :-
    tell('database.txt'),
    listing(inherit),
    listing(attribute),
    listing(instance),
    listing(class),
    told.
