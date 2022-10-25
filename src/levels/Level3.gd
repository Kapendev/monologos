extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	game.grid = Lib.GameGrid.new(6, 5)
	game.win = Vector2(5, 2)
	game.player = Lib.new_actor(Vector2(0, 2))
	game.grid.add_actor(game.player)
	game.grid.add_actor(Lib.new_actor(Vector2(5, 0), "", "mon1|ududl|4"))
	game.grid.add_actor(Lib.new_actor(Vector2(4, 1), "", "mon1|dudur|4"))
	game.grid.add_actor(Lib.new_actor(Vector2(4, 2), "", "mon1|ududl|4"))
	game.grid.add_actor(Lib.new_actor(Vector2(3, 2), "", "mon1|dudur|4"))
	game.grid.add_actor(Lib.new_actor(Vector2(4, 3), "", "mon1|ududl|4"))
	game.grid.add_actor(Lib.new_actor(Vector2(5, 4), "", "mon1|dudur|4"))
	game.grid.add_actor(Lib.new_actor(Vector2(5, 1), "", "mon1|ududl|4"))
	game.grid.add_actor(Lib.new_actor(Vector2(5, 3), "", "mon1|dudur|4"))
	game.grid.add_actor(Lib.new_event(
		game.win,
		"cha1||Level4|...|That feeling.|More of them are nearby.|I know where they are.|I just have to be careful."
	))
	game.init()
