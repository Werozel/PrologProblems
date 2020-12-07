% :- [facts].
:- ['database.txt'].
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



% Сохранение в базу данных
save_all() :-
    tell('database.txt'),
    listing(inherit),
    listing(attribute),
    told.
