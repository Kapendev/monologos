extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	game.grid = Lib.GameGrid.new(4, 4)
	game.player = Lib.new_actor(Vector2())
	game.grid.add_actor(game.player)
	game.init()
