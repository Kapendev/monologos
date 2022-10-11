extends Node

var anim_time := 0.5
var start_time := 2.5

var grid := Lib.new_grid(Vector2())
var player := 0
var player_direction := Vector2.UP

onready var game_map := $GameMap
onready var ui_map := $UiMap
onready var move_buttons := $MoveButtons
onready var tool_buttons := $ToolButtons

func _ready():
	# Create data.
	grid = Lib.new_grid(Vector2(9.0, 9.0))
	player = grid.add_actor((grid.size / 2.0).floor())
	# Setup maps.
	ui_map.grid = grid
	game_map.show_map(start_time)
	# Setup buttons.
	move_buttons.connect("pressed_spin_left", self, "on_pressed_spin_left")
	move_buttons.connect("pressed_move", self, "on_pressed_move")
	move_buttons.connect("pressed_spin_right", self, "on_pressed_spin_right")
	tool_buttons.connect("pressed_map", self, "on_pressed_map")

func spin_player_left() -> void:
	match player_direction:
		Vector2.UP:
			player_direction = Vector2.LEFT
		Vector2.LEFT:
			player_direction = Vector2.DOWN
		Vector2.DOWN:
			player_direction = Vector2.RIGHT
		Vector2.RIGHT:
			player_direction = Vector2.UP

func spin_player_right() -> void:
	match player_direction:
		Vector2.UP:
			player_direction = Vector2.RIGHT
		Vector2.RIGHT:
			player_direction = Vector2.DOWN
		Vector2.DOWN:
			player_direction = Vector2.LEFT
		Vector2.LEFT:
			player_direction = Vector2.UP

func can_move() -> bool:
	return game_map.is_map_visible() \
	and not game_map.is_active()

func on_pressed_spin_left() -> void:
	if can_move():
		game_map.spin_left()
		spin_player_left()

func on_pressed_move() -> void:
	if can_move() and grid.can_move_actor(player, player_direction):
		game_map.move()
		grid.move_actor(player, player_direction)

func on_pressed_spin_right() -> void:
	if can_move():
		game_map.spin_right()
		spin_player_right()

func on_pressed_map() -> void:
	if not game_map.is_active():
		var is_map_visible: bool = game_map.is_map_visible()
		game_map.set_map_visibility(not is_map_visible, anim_time)
		ui_map.set_map_visibility(is_map_visible, anim_time)
