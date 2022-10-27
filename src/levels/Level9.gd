extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	for y in range(0, 7):
		for x in range(0, 7):
			game.ui_map.blacks.append(Vector2(x, y))
	game.win = Vector2(3, 3)
	game.player = Lib.new_actor(Vector2(5, 6))
	game.grid = Lib.GameGrid.new(7, 7)
	game.grid.add_actor(Lib.new_actor(Vector2(4, 3), "", "mon6|dulrlld|2.35"))
	game.grid.add_actor(Lib.new_actor(Vector2(2, 3), "", "mon6|urdldru|2.35"))
	game.grid.add_actor(game.player)
	game.grid.add_actor(Lib.new_event(
		game.win,
		"cha3||Level10|...|\"WoOf!\"|...|Ok.|I will pet you.|\"WoOf!\"|...|Satisfied?|\"WoOf!\"|Woof.|...|Goodbye.|..."
	))
	game.init()
