% :- [facts].
:- ['database.txt'].
:- [map].

% Получение всех аттрибутов в системе
get_all_attributes(Attributes) :- 
    findall(Attribute, attribute(_, Attribute, _), AttributesList),
    list_to_set(AttributesList, Attributes).

% Получение всех аттрибутов для спорта (i, o, o) или значения для спорта и его аттрибута (i, i, i).
get_attributes(Sport, Attribute, Value) :- 
    get_attribute_map(Sport, Map),
    iterate_map(Map, Attribute, Value).

% Получение списка всех уникальных аттрибутов для спорта
get_attribute_map(Sport, ResMap) :- findall(pair(X, Y), get_attributes_duplicates(Sport, X, Y), ResList), make_map(ResList, ResMap).

get_attributes_duplicates(Sport, Attribute, Value) :- attribute(Sport, Attribute, Value).
get_attributes_duplicates(Sport, Attribute, Value) :- 
    inherit(Parent, Sport),
    get_attributes_duplicates(Parent, Attribute, Value).

% Получение конкретного аттрибута для спорта
get_attribute_value(Sport, Attribute, Res) :- 
    get_attributes(Sport, Attribute, Res), 
    !.

% Получение всех видов спорта
get_sports(SportsSet) :- 
    findall(X, get_sports_duplicates(X), Sports), 
    list_to_set(Sports, SportsSet).

get_sports_duplicates(X) :- 
    inherit(_, X), 
    \+ inherit(X, _).

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

% Редактировать аттрибуты спорта
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
    read(Value),    % TODO read string
    edit_sport_attribute(Sport, Attribute, Value).
manage_edit(Sport, 2) :-
    write("Введите аттрибут: "),
    read(Attribute),
    delete_sport_attribute(Sport, Attribute).
manage_edit(_, q) :- 
    start,
    !.
manage_edit(Sport, _) :- manage_edit(Sport).

% Удаление спорта
delete_sport(Sport) :-
    attribute(Sport, Attribute, _),
    retract(attribute(Sport, Attribute, _)),
    retract(inherit(_, Sport)). % TODO add instance()

% Интеракция с пользователем
start :- 
    writeln("1 - Найти все аттрибуты определенного вида спорта"),
    writeln("2 - Найти значение аттрибута для определенного вида спорта"),
    writeln("3 - Найти различия между двумя видами спорта"),
    writeln("4 - Найти все зарегестрированные виды спорта"),
    writeln("5 - Добавить новый вид спорта"),
    writeln("6 - Удалить существующий вид спорта"),
    writeln("7 - Редактировать существующий вид спорта"),
    read(N),
    execute(N). 

% Добавление нового спорта
add_sport(Sport) :- 
    % TODO inherit
    assert(instance(Sport)).

execute(1) :- 
    write("Введите название спорта: "),
    read(Sport),
    findall(
        pair(Attribute, Value), 
        get_attributes(Sport, Attribute, Value), 
        Map
    ),
    print_map(Map).
execute(2) :- 
    write("Введите название спорта: "),
    read(Sport),
    write("Введите название аттрибута: "),
    read(Attribute),
    get_attributes(Sport, Attribute, Value),
    writeln(Value).    
execute(3) :-
    write("Введите название первого спорта: "),
    read(FirstSport),
    write("Введите название второго спорта: "),
    read(SecondSport),
    print_attribute_diff(FirstSport, SecondSport).
execute(4) :-
    get_sports(Sports),
    print_list(Sports).
execute(5) :-
    write("Введите новый спорт: "),
    read(Sport),
    add_sport(Sport).
execute(6) :-
    write("Введите спорт: "),
    read(Sport),
    delete_sport(Sport).
execute(7) :-
    write("Введите спорт: "),
    read(Sport),
    manage_edit(Sport).
execute(_) :- start.

% Сохранение в базу данных
save_all() :-
    tell('database.txt'),
    listing(inherit),
    listing(attribute),
    told.
