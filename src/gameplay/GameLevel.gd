extends Node

var anim_time := 0.5
var start_time := 2.5

var grid: Lib.Grid = null
var player := 0

onready var game_map := $GameMap
onready var ui_map := $UiMap

func _ready():
	# Create data.
	grid = Lib.new_grid(Vector2(5.0, 5.0))
	player = grid.add_actor(Vector2(2.0, 2.0))
	# Setup maps.
	ui_map.grid = grid
	game_map.show_map(start_time)

func _process(_delta) -> void:
	if not game_map.is_active():
		update_ui()
		if game_map.is_map_visible():
			update_position()

func update_ui():
	if Input.is_action_pressed("ui_accept"):
		var is_map_visible: bool = game_map.is_map_visible()
		game_map.set_map_visibility(not is_map_visible, anim_time)
		ui_map.set_map_visibility(is_map_visible, anim_time)

func update_position():
	if Input.is_action_pressed("ui_up"):
		game_map.move()
		grid.move_actor(player, Vector2(0, -1))
	if Input.is_action_pressed("ui_down"):
		game_map.move()
		grid.move_actor(player, Vector2(0, 1))
	if Input.is_action_pressed("ui_left"):
		game_map.spin_left()
		grid.move_actor(player, Vector2(-1, 0))
	if Input.is_action_pressed("ui_right"):
		game_map.spin_right()
		grid.move_actor(player, Vector2(1, 0))
