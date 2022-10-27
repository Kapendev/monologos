extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	for y in range(2, 8):
		for x in range(0, 11):
			game.ui_map.blacks.append(Vector2(x, y))
	game.win = Vector2(5, 0)
	game.player = Lib.new_actor(Vector2(5, 9))
	game.grid = Lib.GameGrid.new(11, 10)
	game.grid.add_wall(Vector2(4, 0))
	game.grid.add_wall(Vector2(6, 0))
	game.grid.add_wall(Vector2(0, 2))
	game.grid.add_wall(Vector2(1, 2))
	game.grid.add_wall(Vector2(2, 2))
	game.grid.add_wall(Vector2(3, 2))
	game.grid.add_wall(Vector2(4, 2))
	game.grid.add_wall(Vector2(5, 2))
	game.grid.add_wall(Vector2(6, 2))
	game.grid.add_wall(Vector2(7, 2))
	game.grid.add_wall(Vector2(8, 2))
	game.grid.add_wall(Vector2(10, 2))
	game.grid.add_wall(Vector2(0, 3))
	game.grid.add_wall(Vector2(6, 3))
	game.grid.add_wall(Vector2(7, 3))
	game.grid.add_wall(Vector2(8, 3))
	game.grid.add_wall(Vector2(10, 3))
	game.grid.add_wall(Vector2(0, 4))
	game.grid.add_wall(Vector2(2, 4))
	game.grid.add_wall(Vector2(4, 4))
	game.grid.add_wall(Vector2(10, 4))
	game.grid.add_wall(Vector2(0, 5))
	game.grid.add_wall(Vector2(2, 5))
	game.grid.add_wall(Vector2(4, 5))
	game.grid.add_wall(Vector2(6, 5))
	game.grid.add_wall(Vector2(8, 5))
	game.grid.add_wall(Vector2(9, 5))
	game.grid.add_wall(Vector2(6, 6))
	game.grid.add_wall(Vector2(1, 7))
	game.grid.add_wall(Vector2(2, 7))
	game.grid.add_wall(Vector2(3, 7))
	game.grid.add_wall(Vector2(4, 7))
	game.grid.add_wall(Vector2(5, 7))
	game.grid.add_wall(Vector2(6, 7))
	game.grid.add_wall(Vector2(7, 7))
	game.grid.add_wall(Vector2(8, 7))
	game.grid.add_wall(Vector2(9, 7))
	game.grid.add_wall(Vector2(4, 9))
	game.grid.add_wall(Vector2(6, 9))
	game.grid.add_wall(Vector2(1, 8))
	game.grid.add_wall(Vector2(9, 8))
	game.grid.add_actor(Lib.new_actor(Vector2(10, 5), "", "mon4|lruldr|2.35"))
	game.grid.add_actor(Lib.new_actor(Vector2(5, 3), "", "mon6|rrluddl|2.35"))
	game.grid.add_actor(Lib.new_actor(Vector2(2, 6), "", "mon4|udludr|2.35"))
	game.grid.add_actor(Lib.new_actor(Vector2(5, 1), "lllllrrrrrrrrrrlllll", "mon6|rdrlrud|2.35"))
	game.grid.add_actor(game.player)
	game.grid.add_actor(Lib.new_event(
		game.win,
		"cha1||Level9|...|I can do it.|I will prove it to you.|Dioni...|..."
	))
	game.init()
