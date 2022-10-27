extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	game.ui_map.blacks = [
		Vector2(3, 0), Vector2(4, 0), Vector2(5, 0), Vector2(6, 0),
		Vector2(3, 2), Vector2(4, 2), Vector2(5, 2), Vector2(6, 2),
		Vector2(3, 4), Vector2(4, 4), Vector2(5, 4), Vector2(6, 4),
	]
	game.win = Vector2(0, 0)
	game.player = Lib.new_actor(Vector2(9, 4))
	game.grid = Lib.GameGrid.new(10, 5)
	game.grid.add_wall(Vector2(3, 1))
	game.grid.add_wall(Vector2(6, 1))
	game.grid.add_wall(Vector2(3, 3))
	game.grid.add_wall(Vector2(6, 3))
	game.grid.add_actor(Lib.new_actor(Vector2(6, 0), "lllllrrrrr", "mon4|lurd|1.35"))
	game.grid.add_actor(Lib.new_actor(Vector2(6, 2), "lllllrrrrr", "mon4|ruld|1.35"))
	game.grid.add_actor(Lib.new_actor(Vector2(6, 4), "lllllrrrrr", "mon4|drul|1.35"))
	game.grid.add_actor(game.player)
	game.grid.add_actor(Lib.new_event(
		game.win,
		"cha1||Level8|...|Nothing will change just by waiting.|Dioni...|I'm almost there.|..."
	))
	game.init()
