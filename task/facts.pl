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

inherit(team, "������ ����").
inherit(water, "������ ����").
inherit(with_ball, "������ ����").
attribute("������ ����", olympic, "�����������").
attribute("������ ����", play_style, "���� ������").

inherit(team, "������").
inherit(on_land, "������").
inherit(with_ball, "������").
attribute("������", olympic, "�����������").
attribute("������", play_style, "���� ������").

inherit(team, "���������").
inherit(on_land, "���������").
inherit(with_ball, "���������").
attribute("���������", olympic, "�����������").
attribute("���������", play_style, "���� ������").
attribute("���������", field, "������������� ��������").

inherit(team, "��������").
inherit(on_land, "��������").
inherit(with_ball, "��������").
attribute("��������", olympic, "�����������").
attribute("��������", play_style, "���� ������").

inherit(team, "������").
inherit(winter, "������").
attribute("������", olympic, "�����������").
attribute("������", equipment, "������").
attribute("������", field, "˸�").

inherit(team, "�������").
inherit(winter, "�������").
attribute("�������", olympic, "�����������").
attribute("�������", equipment, "���� � ��������").
attribute("�������", field, "����������").

inherit(individual, "�������").
inherit(non_physical, "�������").
attribute("�������", olympic, "�����������").
attribute("�������", field, "��������� �����").

inherit(individual, "����").
inherit(on_land, "����").
attribute("����", olympic, "�����������").
attribute("����", equipment, "���������� ��������").
attribute("����", field, "����").

inherit(individual, "�����").
inherit(on_land, "�����").
inherit(with_ball, "�����").
attribute("�����", equipment, "������ ��� ������").

inherit(individual, "������ ����").
inherit(winter, "������ ����").
attribute("������ ����", olympic, "�����������").
attribute("������ ����", equipment, "����").

inherit(non_physical, "����������").
attribute("����������", equipment, "���������").

inherit(water, "������").
attribute("������", olympic, "�����������").
attribute("������", equipment, "�����").
attribute("������", field, "������").

inherit(on_land, "������").
inherit(with_ball, "������").
attribute("������", equipment, "�������").
attribute("������", field, "����").

inherit(on_land, "���������").
attribute("���������", equipment, "�������").
attribute("���������", field, "����").

inherit(winter, "�������").
inherit(team, "�������").
attribute("�������", olympic, "�����������").
attribute("�������", equipment, "����").
attribute("�������", field, "������� ������").

inherit(winter, "�������� �������").
attribute("�������� �������", olympic, "�����������").
attribute("�������� �������", equipment, "������").
