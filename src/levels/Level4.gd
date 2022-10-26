extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	game.win = Vector2(0, 0)
	game.player = Lib.new_actor(Vector2(1, 6))
	game.grid = Lib.GameGrid.new(9, 8)
	game.grid.add_wall(Vector2(0, 2))
	game.grid.add_wall(Vector2(1, 2))
	game.grid.add_wall(Vector2(2, 2))
	game.grid.add_wall(Vector2(3, 2))
	game.grid.add_wall(Vector2(5, 2))
	game.grid.add_wall(Vector2(5, 3))
	game.grid.add_wall(Vector2(5, 4))
	game.grid.add_wall(Vector2(5, 5))
	game.grid.add_wall(Vector2(5, 6))
	game.grid.add_wall(Vector2(6, 2))
	game.grid.add_wall(Vector2(7, 2))
	game.grid.add_wall(Vector2(8, 2))
	game.grid.add_wall(Vector2(3, 3))
	game.grid.add_wall(Vector2(3, 4))
	game.grid.add_wall(Vector2(3, 5))
	game.grid.add_wall(Vector2(3, 6))
	game.grid.add_actor(game.player)
	game.grid.add_actor(Lib.new_actor(Vector2(1, 4), "dduu", "mon2|lrrdrulddd|2.5"))
	game.grid.add_actor(Lib.new_actor(Vector2(7, 6), "llrr", "mon3|udllr|2"))
	game.grid.add_actor(Lib.new_actor(Vector2(7, 4), "rrll", "mon3|dudr|2"))
	game.grid.add_actor(Lib.new_actor(Vector2(4, 4), "dduu", "mon3|dduudd|3"))
	game.grid.add_actor(Lib.new_actor(Vector2(4, 2), "", "mon1|lrrdul|3"))
	game.grid.add_actor(Lib.new_actor(Vector2(1, 0), "", "mon1|ulrdr|3"))
	game.grid.add_actor(Lib.new_event(game.win, "cha1||Level5|...|Despicable creatures.|Following orders without thinking.|They cannot think for themselves.|I can.|I'm stronger.|I'm better.|I'm not Dioni.|..."))
	game.init()
