% :- [facts].
:- ['database.txt'].
:- [map].

% ��������� ���� ���������� � �������
get_all_attributes(Attributes) :- 
    findall(Attribute, attribute(_, Attribute, _), AttributesList),
    list_to_set(AttributesList, Attributes).

% ��������� ���� ���������� ��� ������ (i, o, o) ��� �������� ��� ������ � ��� ��������� (i, i, o).
get_attributes(Sport, Attribute, Value) :- 
    get_attribute_map(Sport, [], Map),
    iterate_map(Map, Attribute, Value).

% ��������� ������ ���� ���������� ���������� ��� ������
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

% ��������� ����������� ��������� ��� ������
get_attribute_value(Sport, Attribute, Res) :- 
    get_attributes(Sport, Attribute, Res), 
    !.

% ��������� ���� ����� ������
get_sports(SportsSet) :- 
    findall(X, instance(X), Sports), 
    list_to_set(Sports, SportsSet).

print_list([]).
print_list([X|T]) :-
    writeln(X),
    print_list(T).

% ��������� �������� � ���������� ��������
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

% ������������� ��������� ������
edit_sport_attribute(Sport, _, _) :-
    \+ inherit(_, Sport),
    writeln("������ ������ �� ����������"),
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
    writeln("1 - ��������/�������� �������� ���������"),
    writeln("2 - ������� ��������"),
    writeln("q - ���������"),
    read(N),
    manage_edit(Sport, N).
manage_edit(Sport, 1) :- 
    write("������� ��������: "),
    read(Attribute),
    write("������� ��������: "),
    read(Value),
    edit_sport_attribute(Sport, Attribute, Value),
    manage_edit(Sport).
manage_edit(Sport, 2) :-
    write("������� ��������: "),
    read(Attribute),
    delete_sport_attribute(Sport, Attribute),
    manage_edit(Sport).
manage_edit(_, q) :- !.
manage_edit(Sport, _) :- manage_edit(Sport).

% �������� ������
dalete_sport(Sport) :-
    not(instance(Sport)),
    writeln("������ ������ �� ����������"),
    !.
delete_sport(Sport) :- retract(attribute(Sport, _, _)).
delete_sport(Sport) :- retract(inherit(_, Sport)).
delete_sport(Sport) :- retract(instance(Sport)).

% ���������� ������ ������
add_sport(Sport) :- 
    assert(instance(Sport)).

add_inherit(Class, Sport) :-
    inherit(Class, Sport),
    !.
add_inherit(Class, Sport) :- 
    assert(inherit(Class, Sport)).

manage_sport_inheritance(Sport) :- 
    \+ instance(Sport),
    writeln("������ ������ �� ����������"),
    !.
manage_sport_inheritance(Sport) :-
    writeln("1 - �������� ����� ������������ ��� ������"),
    writeln("2 - ������� ��� ������ ������������ ��� ������"),
    writeln("q - ���������"),
    read(N),
    manage_sport_inheritance(Sport, N).
manage_sport_inheritance(_, q) :- !.
manage_sport_inheritance(Sport, 1) :-
    write("������� �����: "),
    read(Class),
    add_inherit(Class, Sport),
    manage_sport_inheritance(Sport).
manage_sport_inheritance(Sport, 2) :-
    findall(X, class(X), Classes),
    print_list(Classes),
    manage_sport_inheritance(Sport).
manage_sport_inheritance(Sport, _) :- manage_sport_inheritance(Sport).

% ���������� � �������������
start :- 
    writeln("1 - ����� ��� ��������� ������������� ���� ������"),
    writeln("2 - ����� �������� ��������� ��� ������������� ���� ������"),
    writeln("3 - ����� �������� ����� ����� ������ ������"),
    writeln("4 - ����� ��� ������������������ ���� ������"),
    writeln("5 - �������� ����� ��� ������"),
    writeln("6 - ������� ������������ ��� ������"),
    writeln("7 - ������������� ������������ ��� ������"),
    writeln("q - �����"),
    read(N),
    execute(N). 

execute(1) :- 
    write("������� �������� ������: "),
    read(Sport),
    findall(
        pair(Attribute, Value), 
        get_attributes(Sport, Attribute, Value), 
        Map
    ),
    print_map(Map),
    start.
execute(2) :- 
    write("������� �������� ������: "),
    read(Sport),
    write("������� �������� ���������: "),
    read(Attribute),
    get_attributes(Sport, Attribute, Value),
    writeln(Value),
    start.    
execute(3) :-
    write("������� �������� ������� ������: "),
    read(FirstSport),
    write("������� �������� ������� ������: "),
    read(SecondSport),
    print_attribute_diff(FirstSport, SecondSport),
    start.
execute(4) :-
    get_sports(Sports),
    print_list(Sports),
    start.
execute(5) :-
    write("������� ����� �����: "),
    read(Sport),
    add_sport(Sport),
    manage_sport_inheritance(Sport),
    start.
execute(6) :-
    write("������� �����: "),
    read(Sport),
    delete_sport(Sport),
    start.
execute(7) :-
    write("������� �����: "),
    read(Sport),
    manage_edit(Sport),
    start.
execute(q) :- !.
execute(_) :- start.

% ���������� � ���� ������
save_all :-
    tell('database.txt'),
    listing(inherit),
    listing(attribute),
    listing(instance),
    listing(class),
    told.
