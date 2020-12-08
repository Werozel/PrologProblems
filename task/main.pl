% :- [facts].
:- ['database.txt'].
:- [map].

% ��������� ���� ���������� � �������
get_all_attributes(Attributes) :- 
    findall(Attribute, attribute(_, Attribute, _), AttributesList),
    list_to_set(AttributesList, Attributes).

% ��������� ���� ���������� ��� ������ (i, o, o) ��� �������� ��� ������ � ��� ��������� (i, i, i).
get_attributes(Sport, Attribute, Value) :- 
    get_attribute_map(Sport, Map),
    iterate_map(Map, Attribute, Value).

% ��������� ������ ���� ���������� ���������� ��� ������
get_attribute_map(Sport, ResMap) :- findall(pair(X, Y), get_attributes_duplicates(Sport, X, Y), ResList), make_map(ResList, ResMap).

get_attributes_duplicates(Sport, Attribute, Value) :- attribute(Sport, Attribute, Value).
get_attributes_duplicates(Sport, Attribute, Value) :- 
    inherit(Parent, Sport),
    get_attributes_duplicates(Parent, Attribute, Value).

% ��������� ����������� ��������� ��� ������
get_attribute_value(Sport, Attribute, Res) :- 
    get_attributes(Sport, Attribute, Res), 
    !.

% ��������� ���� ����� ������
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

% ������������� ��������� ������
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
    read(Value),    % TODO read string
    edit_sport_attribute(Sport, Attribute, Value).
manage_edit(Sport, 2) :-
    write("������� ��������: "),
    read(Attribute),
    delete_sport_attribute(Sport, Attribute).
manage_edit(_, q) :- 
    start,
    !.
manage_edit(Sport, _) :- manage_edit(Sport).

% �������� ������
delete_sport(Sport) :-
    attribute(Sport, Attribute, _),
    retract(attribute(Sport, Attribute, _)),
    retract(inherit(_, Sport)). % TODO add instance()

% ���������� � �������������
start :- 
    writeln("1 - ����� ��� ��������� ������������� ���� ������"),
    writeln("2 - ����� �������� ��������� ��� ������������� ���� ������"),
    writeln("3 - ����� �������� ����� ����� ������ ������"),
    writeln("4 - ����� ��� ������������������ ���� ������"),
    writeln("5 - �������� ����� ��� ������"),
    writeln("6 - ������� ������������ ��� ������"),
    writeln("7 - ������������� ������������ ��� ������"),
    read(N),
    execute(N). 

% ���������� ������ ������
add_sport(Sport) :- 
    % TODO inherit
    assert(instance(Sport)).

execute(1) :- 
    write("������� �������� ������: "),
    read(Sport),
    findall(
        pair(Attribute, Value), 
        get_attributes(Sport, Attribute, Value), 
        Map
    ),
    print_map(Map).
execute(2) :- 
    write("������� �������� ������: "),
    read(Sport),
    write("������� �������� ���������: "),
    read(Attribute),
    get_attributes(Sport, Attribute, Value),
    writeln(Value).    
execute(3) :-
    write("������� �������� ������� ������: "),
    read(FirstSport),
    write("������� �������� ������� ������: "),
    read(SecondSport),
    print_attribute_diff(FirstSport, SecondSport).
execute(4) :-
    get_sports(Sports),
    print_list(Sports).
execute(5) :-
    write("������� ����� �����: "),
    read(Sport),
    add_sport(Sport).
execute(6) :-
    write("������� �����: "),
    read(Sport),
    delete_sport(Sport).
execute(7) :-
    write("������� �����: "),
    read(Sport),
    manage_edit(Sport).
execute(_) :- start.

% ���������� � ���� ������
save_all() :-
    tell('database.txt'),
    listing(inherit),
    listing(attribute),
    told.
