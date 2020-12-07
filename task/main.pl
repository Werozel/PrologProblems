:- [facts].
% :- ['database.txt'].
:- [map].

% ��������� ���� ���������� ��� ������ (i, o, o) ��� �������� ��� ������ � ��� ��������� (i, i, i).
get_attributes(Sport, Attribute, Value) :- 
    get_attribute_map(Sport, Map),
    iterate_map(Map, Attribute, Value).

% ��������� ������ ���� ���������� ����������
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

% ��������� �������� � ���������� ��������
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

% ���������� � �������������
start :- 
    writeln("1 - ����� ��� ��������� ������������� ���� ������"),
    writeln("2 - ����� �������� ��������� ��� ������������� ���� ������"),
    writeln("3 - ����� �������� ����� ����� ������ ������"),
    read(N),
    execute(N). 

execute(1) :- 
    write("������� �������� ������: "),
    read(Sport),
    findall(pair(Attribute, Value), get_attributes(Sport, Attribute, Value), Map),
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

% ���������� � ���� ������
save_all() :-
    tell('database.txt'),
    listing(inherit),
    listing(attribute),
    told.
