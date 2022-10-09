extends Node

var show_time := 0.5
var start_show_time := 3.0
onready var game_map := $GameMap
onready var map := $Map

func _ready():
	game_map.show_map(start_show_time)

func _input(event) -> void:
	if game_map.is_map_visible():
		if event.is_action_pressed("ui_up"):
			game_map.move()
		if event.is_action_pressed("ui_left"):
			game_map.spin_left()
		if event.is_action_pressed("ui_right"):
			game_map.spin_right()
	if event.is_action_pressed("ui_accept"):
		var is_map_visible: bool = game_map.is_map_visible()
		game_map.set_map_visibility(not is_map_visible, show_time)
		map.set_map_visibility(is_map_visible, show_time)
