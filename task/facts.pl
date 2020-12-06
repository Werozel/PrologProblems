
inherit(sport, non_physical).
inherit(sport, physical).

inherit(sport, team).
inherit(sport, individual).

inherit(team, "Водное поло").
inherit(team, "Футбол").
inherit(team, "Баскетбол").
inherit(team, "Волейбол").
inherit(team, "Хоккей").
inherit(team, "Биатлон").

inherit(individual, "Шахматы").
inherit(individual, "Бокс").
inherit(individual, "Гольф").
inherit(individual, "Горные лыжи").

inherit(non_physical, "Киберспорт").
inherit(non_physical, "Шахматы").

inherit(physical, summer).
inherit(physical, winter).

inherit(summer, water).
inherit(summer, on_land).
inherit(summer, with_ball).

inherit(water, "Водное поло").
inherit(water, "Гребля").

inherit(on_land, "Футбол").
inherit(on_land, "Теннис").
inherit(on_land, "Бадминтон").
inherit(on_land, "Баскетбол").
inherit(on_land, "Бокс").
inherit(on_land, "Волейбол").
inherit(on_land, "Гольф").

inherit(with_ball, "Водное поло").
inherit(with_ball, "Футбол").
inherit(with_ball, "Теннис").
inherit(with_ball, "Баскетбол").
inherit(with_ball, "Волейбол").
inherit(with_ball, "Гольф").

inherit(winter, "Бобслей").
inherit(winter, "Биатлон").
inherit(winter, "Горные лыжи").
inherit(winter, "Фигурное катание").
inherit(winter, "Хоккей").
