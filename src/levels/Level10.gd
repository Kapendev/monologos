extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	game.game_map.wind_music.stream = null
	for y in range(0, 8):
		game.ui_map.blacks.append(Vector2(0, y))
	game.player = Lib.new_actor(Vector2(0, 7))
	game.grid = Lib.GameGrid.new(1, 8)
	game.grid.add_actor(game.player)
	game.grid.add_actor(Lib.new_event(
		Vector2(0, 0),
		"cha2||Level11|...|dwa.|ovbyv...|pa.|cbshj.|..."
	))
	game.init()
