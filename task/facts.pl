:- dynamic inherit / 2.
:- dynamic attribute / 3.
:- dynamic instance / 1.
:- dynamic class / 1.

:- discontiguous inherit/2.
:- discontiguous attribute/3.
:- discontiguous instance / 1.
:- discontiguous class / 1.

class(non_physical).
inherit(sport, non_physical).
attribute(non_physical, physically, "����������������").
class(physical).
inherit(sport, physical).
attribute(physical, physically, "����������").

class(team).
inherit(sport, team).
attribute(team, players, "���������").
class(individual).
inherit(sport, individual).
attribute(individual, players, "��������������").

class(summer).
inherit(physical, summer).
attribute(summer, season, "������").
class(winter).
inherit(physical, winter).
attribute(winter, season, "������").

class(water).
inherit(summer, water).
attribute(water, field, "�������").
class(on_land).
inherit(summer, on_land).
attribute(on_land, field, "����").
class(with_ball).
inherit(summer, with_ball).
attribute(with_ball, item, "���").

instance(water_polo).
inherit(team, water_polo).
inherit(water, water_polo).
inherit(with_ball, water_polo).
attribute(water_polo, olympic, "�����������").
attribute(water_polo, play_style, "���� ������").

instance(football).
inherit(team, football).
inherit(on_land, football).
inherit(with_ball, football).
attribute(football, olympic, "�����������").
attribute(football, play_style, "���� ������").

instance(basketball).
inherit(team, basketball).
inherit(on_land, basketball).
inherit(with_ball, basketball).
attribute(basketball, olympic, "�����������").
attribute(basketball, play_style, "���� ������").
attribute(basketball, field, "������������� ��������").

instance(vollyeball).
inherit(team, vollyeball).
inherit(on_land, vollyeball).
inherit(with_ball, vollyeball).
attribute(vollyeball, olympic, "�����������").
attribute(vollyeball, play_style, "���� ������").

instance(hockey).
inherit(team, hockey).
inherit(winter, hockey).
attribute(hockey, olympic, "�����������").
attribute(hockey, equipment, "������").
attribute(hockey, field, "˸�").

instance(badminton).
inherit(team, biathlon).
inherit(winter, biathlon).
attribute(biathlon, olympic, "�����������").
attribute(biathlon, equipment, "���� � ��������").
attribute(biathlon, field, "����������").

instance(chess).
inherit(individual, chess).
inherit(non_physical, chess).
attribute(chess, olympic, "�����������").
attribute(chess, field, "��������� �����").

instance(boxing).
inherit(individual, boxing).
inherit(on_land, boxing).
attribute(boxing, olympic, "�����������").
attribute(boxing, equipment, "���������� ��������").
attribute(boxing, field, "����").

instance(golf).
inherit(individual, golf).
inherit(on_land, golf).
inherit(with_ball, golf).
attribute(golf, equipment, "������ ��� ������").

instance(skiing).
inherit(individual, skiing).
inherit(winter, skiing).
attribute(skiing, olympic, "�����������").
attribute(skiing, equipment, "����").

instance(esports).
inherit(non_physical, esports).
attribute(esports, equipment, "���������").

instance(rowing).
inherit(water, rowing).
attribute(rowing, olympic, "�����������").
attribute(rowing, equipment, "�����").
attribute(rowing, field, "������").

instance(tennis).
inherit(on_land, tennis).
inherit(with_ball, tennis).
attribute(tennis, equipment, "�������").
attribute(tennis, field, "����").

instance(badminton).
inherit(on_land, badminton).
attribute(badminton, equipment, "�������").
attribute(badminton, field, "����").

instance(bobsleigh).
inherit(winter, bobsleigh).
inherit(team, bobsleigh).
attribute(bobsleigh, olympic, "�����������").
attribute(bobsleigh, equipment, "����").
attribute(bobsleigh, field, "������� ������").

instance(figure_skating).
inherit(winter, figure_skating).
attribute(figure_skating, olympic, "�����������").
attribute(figure_skating, equipment, "������").
