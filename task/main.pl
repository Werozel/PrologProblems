% :- [facts].
:- ['database.txt'].

get_attributes(Sport, Attribute, Value) :- attribute(Sport, Attribute, Value).
get_attributes(Sport, Attribute, Value) :- 
    inherit(Parent, Sport),
    get_attributes(Parent, Attribute, Value).


get_attribute_value(Sport, Attribute, Res) :- 
    get_attributes(Sport, Attribute, Res), 
    !.

get_sports_duplicates(X) :- 
    inherit(_, X), 
    \+ inherit(X, _).

get_sports(SportsSet) :- 
    findall(X, get_sports_duplicates(X), Sports), 
    list_to_set(Sports, SportsSet).

save_all() :-
    tell('database.txt'),
    listing(inherit),
    listing(attribute),
    told.
