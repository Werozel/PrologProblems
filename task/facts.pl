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
attribute(non_physical, physically, "Интеллектуальный").
class(physical).
inherit(sport, physical).
attribute(physical, physically, "Физический").

class(team).
inherit(sport, team).
attribute(team, players, "Командный").
class(individual).
inherit(sport, individual).
attribute(individual, players, "Индивидуальный").

class(summer).
inherit(physical, summer).
attribute(summer, season, "Летний").
class(winter).
inherit(physical, winter).
attribute(winter, season, "Зимний").

class(water).
inherit(summer, water).
attribute(water, field, "Бассейн").
class(on_land).
inherit(summer, on_land).
attribute(on_land, field, "Поле").
class(with_ball).
inherit(summer, with_ball).
attribute(with_ball, item, "Мяч").

instance(water_polo).
inherit(team, water_polo).
inherit(water, water_polo).
inherit(with_ball, water_polo).
attribute(water_polo, olympic, "Олимпийский").
attribute(water_polo, play_style, "Игра руками").

instance(football).
inherit(team, football).
inherit(on_land, football).
inherit(with_ball, football).
attribute(football, olympic, "Олимпийский").
attribute(football, play_style, "Игра ногами").

instance(basketball).
inherit(team, basketball).
inherit(on_land, basketball).
inherit(with_ball, basketball).
attribute(basketball, olympic, "Олимпийский").
attribute(basketball, play_style, "Игра руками").
attribute(basketball, field, "Баскетбольная площадка").

instance(vollyeball).
inherit(team, vollyeball).
inherit(on_land, vollyeball).
inherit(with_ball, vollyeball).
attribute(vollyeball, olympic, "Олимпийский").
attribute(vollyeball, play_style, "Игра руками").

instance(hockey).
inherit(team, hockey).
inherit(winter, hockey).
attribute(hockey, olympic, "Олимпийский").
attribute(hockey, equipment, "Клюшка").
attribute(hockey, field, "Лёд").

instance(badminton).
inherit(team, biathlon).
inherit(winter, biathlon).
attribute(biathlon, olympic, "Олимпийский").
attribute(biathlon, equipment, "Лыжи и винтовка").
attribute(biathlon, field, "Стрельбище").

instance(chess).
inherit(individual, chess).
inherit(non_physical, chess).
attribute(chess, olympic, "Олимпийский").
attribute(chess, field, "Шахматная доска").

instance(boxing).
inherit(individual, boxing).
inherit(on_land, boxing).
attribute(boxing, olympic, "Олимпийский").
attribute(boxing, equipment, "Боксерский перчатки").
attribute(boxing, field, "Ринг").

instance(golf).
inherit(individual, golf).
inherit(on_land, golf).
inherit(with_ball, golf).
attribute(golf, equipment, "Клюшка для гольфа").

instance(skiing).
inherit(individual, skiing).
inherit(winter, skiing).
attribute(skiing, olympic, "Олимпийский").
attribute(skiing, equipment, "Лыжи").

instance(esports).
inherit(non_physical, esports).
attribute(esports, equipment, "Компьютер").

instance(rowing).
inherit(water, rowing).
attribute(rowing, olympic, "Олимпийский").
attribute(rowing, equipment, "Лодка").
attribute(rowing, field, "Водоем").

instance(tennis).
inherit(on_land, tennis).
inherit(with_ball, tennis).
attribute(tennis, equipment, "Ракетка").
attribute(tennis, field, "Корт").

instance(badminton).
inherit(on_land, badminton).
attribute(badminton, equipment, "Ракетка").
attribute(badminton, field, "Корт").

instance(bobsleigh).
inherit(winter, bobsleigh).
inherit(team, bobsleigh).
attribute(bobsleigh, olympic, "Олимпийский").
attribute(bobsleigh, equipment, "Сани").
attribute(bobsleigh, field, "Ледовая трасса").

instance(figure_skating).
inherit(winter, figure_skating).
attribute(figure_skating, olympic, "Олимпийский").
attribute(figure_skating, equipment, "Коньки").
