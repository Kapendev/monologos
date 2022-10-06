extends Node

onready var game_map := $GameMap

func _input(event) -> void:
	if event.is_action_pressed("ui_up"):
		game_map.move()
