extends Node

var is_attacking := false # maybe make a state thingy

var key_time := 0.1
var move_time := 0.3
var map_time := 0.5
var map_start_time := 2.5

var grid: Lib.Grid
var player: Vector2
var player_direction := Vector2.UP

onready var game_map := $GameMap
onready var move_buttons := $MoveButtons
onready var tool_buttons := $ToolButtons
onready var ui_map := $UiMap
onready var ui_turn_counter := $UiTurnCounter
onready var qte_screen := $QteScreen

func _ready():
	randomize()
	# Create data.
	grid = Lib.Grid.new(9, 9)
	player = grid.add_friend(Vector2(), 0, 0, "")
	for _i in range(randi() % 4):
		spin_player_left()
		game_map.spin_left_now()
	grid.add_enemy(Vector2(2, 2), 0, 0, "mon2|lrludddrrr") #roedpawojdpoawjs
	# Setup maps.
	ui_map.grid = grid
	game_map.show_map(map_start_time)
	# Setup buttons.
	move_buttons.connect("pressed_spin_left", self, "on_pressed_spin_left")
	move_buttons.connect("pressed_move", self, "on_pressed_move")
	move_buttons.connect("pressed_spin_right", self, "on_pressed_spin_right")
	tool_buttons.connect("pressed_map", self, "on_pressed_map")

func attack(target: Vector2) -> void:
	is_attacking = true
	var enemy_data := grid.get_actor_data(target)
	var enemy_name: String = enemy_data[0]
	var enemy_codes: String = enemy_data[1]
	game_map.target.texture = Lib.load_sprite(enemy_name)
	qte_screen.create_keys(enemy_codes, key_time, move_time - key_time + 0.1)

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
	and not game_map.is_active() \
	and not is_attacking

func on_pressed_spin_left() -> void:
	if can_move():
		game_map.spin_left(move_time)
		spin_player_left()

func on_pressed_spin_right() -> void:
	if can_move():
		game_map.spin_right(move_time)
		spin_player_right()

func on_pressed_move() -> void:
	if can_move():
		var target := player + player_direction
		if grid.exists(target) and not grid.is_wall(target):
			if grid.is_enemy(target):
				attack(target)
			elif grid.is_friend(target):
				print("talk")
			player = grid.move_actor(player, target)
			game_map.move(move_time)
			ui_turn_counter.add()
		else:
			game_map.dont_move(move_time)

func on_pressed_map() -> void:
	if not game_map.is_active() and not is_attacking:
		var is_map_visible: bool = game_map.is_map_visible()
		game_map.set_map_visibility(not is_map_visible, map_time)
		ui_turn_counter.set_counter_visibility(not is_map_visible, map_time)
		ui_map.set_map_visibility(is_map_visible, map_time)
		if is_map_visible:
			ui_turn_counter.add()
