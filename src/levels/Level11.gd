extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	game.connect("attack_win_ended", self, "on_win")
	game.connect("attack_lost_ended", self, "on_lost")
	game.game_map.bgm.stream = null
	game.game_map.wind_music.stream = null
	game.game_map.death_sound.stream = null
	game.game_map.ghost_sound.stream = null
	game.game_map.boop_sound.stream = null
	game.game_map.run_sound.stream = null
	#game.qte_screen.hit_sound.stream = null
	game.ui_map.blacks.append(Vector2(0, 0))
	game.ui_map.blacks.append(Vector2(0, 1))
	game.player = Lib.new_actor(Vector2(0, 1))
	game.grid = Lib.GameGrid.new(1, 2)
	game.grid.add_actor(Lib.new_actor(Vector2(0, 0), "", "mon9|d|11"))
	game.grid.add_actor(game.player)
	game.init()

func on_win():
	get_tree().change_scene("res://src/End.tscn")

func on_lost():
	get_tree().change_scene("res://src/End.tscn")
