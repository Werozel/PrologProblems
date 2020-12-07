% :- [facts].
:- ['database.txt'].
:- [map].

% Получение списка всех аттрибутов в системе
get_attribute_map(Sport, ResMap) :- findall(pair(X, Y), get_attributes(Sport, X, Y), ResList), make_map(ResList, ResMap).

% Получение всех аттрибутов для спорта
get_attributes(Sport, Attribute, Value) :- attribute(Sport, Attribute, Value).
get_attributes(Sport, Attribute, Value) :- 
    inherit(Parent, Sport),
    get_attributes(Parent, Attribute, Value).

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

% Сохранение в базу данных
save_all() :-
    tell('database.txt'),
    listing(inherit),
    listing(attribute),
    told.
