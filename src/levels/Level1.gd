extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	game.grid = Lib.GameGrid.new(1, 8)
	game.win = Vector2(0, 0)
	game.player = Lib.new_actor(Vector2(0, 7))
	game.grid.add_actor(game.player)
	game.grid.add_actor(Lib.new_event(
		game.win,
		"cha1||Level2|...|I'm almost there.|I feel it.|..."
	))
	game.init()
