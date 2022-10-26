extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	game.grid = Lib.GameGrid.new(5, 5)
	game.win = Vector2(2, 0)
	game.player = Lib.new_actor(Vector2(2, 4))
	game.grid.add_actor(game.player)
	game.grid.add_wall(Vector2(2, 2))
	game.grid.add_wall(Vector2(4, 2))
	game.grid.add_wall(Vector2(0, 2))
	game.grid.add_actor(Lib.new_event(
		game.win,
		"cha1||Level3|...|I'm not Dioni.|I'm not Dioni.|I don't know who I am.|But I'm not Dioni.|And I will prove it to you.|..."
	))
	game.init()
