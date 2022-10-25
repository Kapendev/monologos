extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	game.win = Vector2(0, 0)
	game.player = Lib.new_actor(Vector2(0, 0))
	game.grid = Lib.GameGrid.new(14, 5)
	game.grid.add_actor(game.player)
	game.init()
