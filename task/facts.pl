:- dynamic inherit / 2.
:- dynamic attribute / 3.

:- discontiguous inherit/2.
:- discontiguous attribute/3.

inherit(sport, non_physical).
attribute(non_physical, physically, "Интеллектуальный").
inherit(sport, physical).
attribute(physical, physically, "Физический").

inherit(sport, team).
attribute(team, players, "Командный").
inherit(sport, individual).
attribute(individual, players, "Индивидуальный").

inherit(physical, summer).
attribute(summer, season, "Летний").
inherit(physical, winter).
attribute(winter, season, "Зимний").

inherit(summer, water).
attribute(water, field, "Бассейн").
inherit(summer, on_land).
attribute(on_land, field, "Поле").
inherit(summer, with_ball).
attribute(with_ball, item, "Мяч").

inherit(team, water_polo).
inherit(water, water_polo).
inherit(with_ball, water_polo).
attribute(water_polo, olympic, "Олимпийский").
attribute(water_polo, play_style, "Игра руками").

inherit(team, football).
inherit(on_land, football).
inherit(with_ball, football).
attribute(football, olympic, "Олимпийский").
attribute(football, play_style, "Игра ногами").

inherit(team, basketball).
inherit(on_land, basketball).
inherit(with_ball, basketball).
attribute(basketball, olympic, "Олимпийский").
attribute(basketball, play_style, "Игра руками").
attribute(basketball, field, "Баскетбольная площадка").

inherit(team, vollyeball).
inherit(on_land, vollyeball).
inherit(with_ball, vollyeball).
attribute(vollyeball, olympic, "Олимпийский").
attribute(vollyeball, play_style, "Игра руками").

inherit(team, hockey).
inherit(winter, hockey).
attribute(hockey, olympic, "Олимпийский").
attribute(hockey, equipment, "Клюшка").
attribute(hockey, field, "Лёд").

inherit(team, biathlon).
inherit(winter, biathlon).
attribute(biathlon, olympic, "Олимпийский").
attribute(biathlon, equipment, "Лыжи и винтовка").
attribute(biathlon, field, "Стрельбище").

inherit(individual, chess).
inherit(non_physical, chess).
attribute(chess, olympic, "Олимпийский").
attribute(chess, field, "Шахматная доска").

inherit(individual, boxing).
inherit(on_land, boxing).
attribute(boxing, olympic, "Олимпийский").
attribute(boxing, equipment, "Боксерский перчатки").
attribute(boxing, field, "Ринг").

inherit(individual, golf).
inherit(on_land, golf).
inherit(with_ball, golf).
attribute(golf, equipment, "Клюшка для гольфа").

inherit(individual, skiing).
inherit(winter, skiing).
attribute(skiing, olympic, "Олимпийский").
attribute(skiing, equipment, "Лыжи").

inherit(non_physical, esports).
attribute(esports, equipment, "Компьютер").

inherit(water, rowing).
attribute(rowing, olympic, "Олимпийский").
attribute(rowing, equipment, "Лодка").
attribute(rowing, field, "Водоем").

inherit(on_land, tennis).
inherit(with_ball, tennis).
attribute(tennis, equipment, "Ракетка").
attribute(tennis, field, "Корт").

inherit(on_land, badminton).
attribute(badminton, equipment, "Ракетка").
attribute(badminton, field, "Корт").

inherit(winter, bobsleigh).
inherit(team, bobsleigh).
attribute(bobsleigh, olympic, "Олимпийский").
attribute(bobsleigh, equipment, "Сани").
attribute(bobsleigh, field, "Ледовая трасса").

inherit(winter, figure_skating).
attribute(figure_skating, olympic, "Олимпийский").
attribute(figure_skating, equipment, "Коньки").
