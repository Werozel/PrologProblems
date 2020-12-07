:- dynamic inherit / 2.
:- dynamic attribute / 3.

:- discontiguous inherit/2.
:- discontiguous attribute/3.

inherit(sport, non_physical).
attribute(non_physical, physically, "����������������").
inherit(sport, physical).
attribute(physical, physically, "����������").

inherit(sport, team).
attribute(team, players, "���������").
inherit(sport, individual).
attribute(individual, players, "��������������").

inherit(physical, summer).
attribute(summer, season, "������").
inherit(physical, winter).
attribute(winter, season, "������").

inherit(summer, water).
attribute(water, field, "�������").
inherit(summer, on_land).
attribute(on_land, field, "����").
inherit(summer, with_ball).
attribute(with_ball, item, "���").

inherit(team, water_polo).
inherit(water, water_polo).
inherit(with_ball, water_polo).
attribute(water_polo, olympic, "�����������").
attribute(water_polo, play_style, "���� ������").

inherit(team, football).
inherit(on_land, football).
inherit(with_ball, football).
attribute(football, olympic, "�����������").
attribute(football, play_style, "���� ������").

inherit(team, basketball).
inherit(on_land, basketball).
inherit(with_ball, basketball).
attribute(basketball, olympic, "�����������").
attribute(basketball, play_style, "���� ������").
attribute(basketball, field, "������������� ��������").

inherit(team, vollyeball).
inherit(on_land, vollyeball).
inherit(with_ball, vollyeball).
attribute(vollyeball, olympic, "�����������").
attribute(vollyeball, play_style, "���� ������").

inherit(team, hockey).
inherit(winter, hockey).
attribute(hockey, olympic, "�����������").
attribute(hockey, equipment, "������").
attribute(hockey, field, "˸�").

inherit(team, biathlon).
inherit(winter, biathlon).
attribute(biathlon, olympic, "�����������").
attribute(biathlon, equipment, "���� � ��������").
attribute(biathlon, field, "����������").

inherit(individual, chess).
inherit(non_physical, chess).
attribute(chess, olympic, "�����������").
attribute(chess, field, "��������� �����").

inherit(individual, boxing).
inherit(on_land, boxing).
attribute(boxing, olympic, "�����������").
attribute(boxing, equipment, "���������� ��������").
attribute(boxing, field, "����").

inherit(individual, golf).
inherit(on_land, golf).
inherit(with_ball, golf).
attribute(golf, equipment, "������ ��� ������").

inherit(individual, skiing).
inherit(winter, skiing).
attribute(skiing, olympic, "�����������").
attribute(skiing, equipment, "����").

inherit(non_physical, esports).
attribute(esports, equipment, "���������").

inherit(water, rowing).
attribute(rowing, olympic, "�����������").
attribute(rowing, equipment, "�����").
attribute(rowing, field, "������").

inherit(on_land, tennis).
inherit(with_ball, tennis).
attribute(tennis, equipment, "�������").
attribute(tennis, field, "����").

inherit(on_land, badminton).
attribute(badminton, equipment, "�������").
attribute(badminton, field, "����").

inherit(winter, bobsleigh).
inherit(team, bobsleigh).
attribute(bobsleigh, olympic, "�����������").
attribute(bobsleigh, equipment, "����").
attribute(bobsleigh, field, "������� ������").

inherit(winter, figure_skating).
attribute(figure_skating, olympic, "�����������").
attribute(figure_skating, equipment, "������").
