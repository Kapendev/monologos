extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	game.win = Vector2(14, 4)
	game.player = Lib.new_actor(Vector2(10, 2))
	game.grid = Lib.GameGrid.new(15, 5)
	game.grid.add_wall(Vector2(9, 0))
	game.grid.add_wall(Vector2(6, 1))
	game.grid.add_wall(Vector2(5, 1))
	game.grid.add_wall(Vector2(9, 1))
	game.grid.add_wall(Vector2(5, 2))
	game.grid.add_wall(Vector2(9, 2))
	game.grid.add_wall(Vector2(5, 3))
	game.grid.add_wall(Vector2(8, 3))
	game.grid.add_wall(Vector2(9, 3))
	game.grid.add_wall(Vector2(14, 3))
	game.grid.add_wall(Vector2(5, 4))
	game.grid.add_actor(game.player)
	game.grid.add_actor(Lib.new_actor(Vector2(3, 2), "uurrrddl", "mon3|lrrlld|2.5"))
	game.grid.add_actor(Lib.new_actor(Vector2(4, 4), "uurrrddl", "mon3|drudlld|2.5"))
	game.grid.add_actor(Lib.new_actor(Vector2(0, 4), "uurrrddl", "mon3|rdurrd|2.5"))
	game.grid.add_actor(Lib.new_actor(Vector2(13, 2), "ud", "mon3|uurlr|2.5"))
	game.grid.add_actor(Lib.new_actor(Vector2(13, 3), "ud", "mon3|lrurdd|2.5"))
	game.grid.add_actor(Lib.new_actor(Vector2(12, 3), "du", "mon3|llrudu|2.5"))
	game.grid.add_actor(Lib.new_actor(Vector2(11, 2), "lr", "mon3|duurlld|3"))
	game.grid.add_actor(Lib.new_actor(Vector2(12, 1), "ullrr", "mon2|duduludrdurl|3"))
	game.grid.add_actor(Lib.new_actor(Vector2(11, 1), "llrr", "mon2|urdulrlruddl|3"))
	game.grid.add_actor(Lib.new_actor(Vector2(11, 3), "", "mon1|rururd|2.5"))
	game.grid.add_actor(Lib.new_actor(Vector2(13, 1), "", "mon1|durluu|3"))
	game.grid.add_actor(Lib.new_actor(Vector2(1, 2), "", "mon1|rdurrd|2.5"))
	game.grid.add_actor(Lib.new_actor(Vector2(13, 4), "", "mon1|drudlld|2.5"))
	game.grid.add_actor(Lib.new_event(game.win, "cha3||Level6|\"WoOf!\"|...|\"WoOf!\"|...|I'm not going to pet you.|\"WoOf!\"|Woof.|Bye.|..."))
	game.init()
