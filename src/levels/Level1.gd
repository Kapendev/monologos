extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	game.grid = Lib.GameGrid.new(10, 1)
	game.player = Lib.new_actor(Vector2())
	game.grid.add_actor(game.player)
	game.grid.add_actor(Lib.new_event(Vector2(3, 0), "cha1|||Hello world.|The end.|Or something.|Funny.|Maybe bad."))
	game.grid.add_actor(Lib.new_event(Vector2(4, 0), "cha2||Level2|Hello world 222|yea"))
	game.init()
