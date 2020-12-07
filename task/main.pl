:- [facts].
% :- ['database.txt'].
:- [map].

% Получение всех аттрибутов для спорта (i, o, o) или значения для спорта и его аттрибута (i, i, i).
get_attributes(Sport, Attribute, Value) :- 
    get_attribute_map(Sport, Map),
    iterate_map(Map, Attribute, Value).

% Получение списка всех уникальных аттрибутов
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

% Получение различия в конкретном атрибуте
get_attribute_diff(Sport, Sport, _, "None") :- !.
get_attribute_diff(FirstSport, SecondSport, Attribute, "None") :- 
    get_attributes(FirstSport, Attribute, Value),
    get_attributes(SecondSport, Attribute, Value).
get_attribute_diff(FirstSport, SecondSport, Attribute, pair(FirstValue, SecondValue)) :-
    get_attributes(FirstSport, Attribute, FirstValue),
    get_attributes(SecondSport, Attribute, SecondValue),
    dif(FirstValue, SecondValue).
get_attribute_diff(FirstSport, SecondSport, Attribute, pair(FirstValue, "None")) :-
    get_attributes(FirstSport, Attribute, FirstValue),
    \+ get_attributes(SecondSport, Attribute, _).
get_attribute_diff(FirstSport, SecondSport, Attribute, pair("None", SecondValue)) :-
    get_attributes(SecondSport, Attribute, SecondValue),
    \+ get_attributes(FirstSport, Attribute, _).

print_attribute_diff(FirstSport, SecondSport) :-
    findall(pair(Attribute, Difference), get_attribute_diff(FirstSport, SecondSport, Attribute, Difference), ResultList),
    make_map(ResultList, ResultMap),
    print_difference(ResultMap).

% Интеракция с пользователем
start :- 
    writeln("1 - Найти все аттрибуты определенного вида спорта"),
    writeln("2 - Найти значение аттрибута для определенного вида спорта"),
    writeln("3 - Найти различия между двумя видами спорта"),
    read(N),
    execute(N). 

execute(1) :- 
    write("Введите название спорта: "),
    read(Sport),
    findall(pair(Attribute, Value), get_attributes(Sport, Attribute, Value), Map),
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

% Сохранение в базу данных
save_all() :-
    tell('database.txt'),
    listing(inherit),
    listing(attribute),
    told.
