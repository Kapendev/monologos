extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	game.win = Vector2(0, 0)
	game.player = Lib.new_actor(Vector2(0, 7))
	game.grid = Lib.GameGrid.new(1, 8)
	game.grid.add_actor(game.player)
	game.grid.add_actor(Lib.new_event(game.win, "cha1||Level7|...|Dioni must be hiding somewhere nearby.|I can feel her.|The end is near.|..."))
	game.init()
