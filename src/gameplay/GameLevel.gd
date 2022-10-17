extends Node

enum GameState {
	IDLE, MAP, MOVE, ATTACK, TALK, DEATH, WIN
}

var state := 0

var key_time := 0.1
var move_time := 0.3
var map_time := 0.5
var map_start_time := 2.5

var grid: Lib.Grid
var player: Vector2
var player_direction := Vector2.UP

onready var game_map := $GameMap
onready var move_buttons := $MoveButtons
onready var ui_map := $UiMap
onready var ui_turn_counter := $UiTurnCounter
onready var qte_screen := $QteScreen

func _ready():
	# Connect buttons.
	move_buttons.connect("pressed_left", self, "on_pressed_left")
	move_buttons.connect("pressed_up", self, "on_pressed_up")
	move_buttons.connect("pressed_right", self, "on_pressed_right")
	move_buttons.connect("pressed_down", self, "on_pressed_down")
	# Connect maps and qte.
	game_map.connect("map_position_changed", self, "on_gamemap_position_changed")
	game_map.connect("map_visibility_changed", self, "on_gamemap_visibility_changed")
	
	# Create data.
	randomize()
	grid = Lib.Grid.new(9, 9)
	player = grid.add_friend(Vector2(), 0, 0, "")
	for _i in range(randi() % 4):
		spin_player_left()
		game_map.spin_left_now()
	grid.add_enemy(Vector2(2, 2), 0, 0, "mon2|lrludddrrr")
	# Setup maps.
	ui_map.grid = grid
	game_map.show_map(map_start_time)

func attack(target: Vector2) -> void:
	var enemy_data := grid.get_actor_data(target)
	var enemy_name: String = enemy_data[0]
	var enemy_code: String = enemy_data[1]
	game_map.target.texture = Lib.load_sprite(enemy_name)
	qte_screen.create_keys(enemy_code, key_time, move_time - key_time + 0.1)
	state = GameState.ATTACK

func talk(_target: Vector2) -> void:
	state = GameState.TALK

func on_pressed_left() -> void:
	if state == GameState.IDLE:
		game_map.spin_left(move_time)
		spin_player_left()
		state = GameState.MOVE

func on_pressed_right() -> void:
	if state == GameState.IDLE:
		game_map.spin_right(move_time)
		spin_player_right()
		state = GameState.MOVE

func on_pressed_up() -> void:
	if state == GameState.IDLE:
		var target := player + player_direction
		if grid.exists(target) and not grid.is_wall(target):
			if grid.is_enemy(target):
				attack(target)
			elif grid.is_friend(target):
				talk(target)
			else:
				state = GameState.MOVE
			game_map.move(move_time)
			ui_turn_counter.add()
			player = grid.move_actor(player, target)
		else:
			game_map.dont_move(move_time)
			state = GameState.MOVE

func on_pressed_down() -> void:
	if state == GameState.IDLE:
		game_map.set_map_visibility(false, map_time)
		ui_turn_counter.set_counter_visibility(false, map_time)
		ui_map.set_map_visibility(true, map_time)
		state = GameState.MAP
	elif state == GameState.MAP:
		game_map.set_map_visibility(true, map_time)
		ui_turn_counter.set_counter_visibility(true, map_time)
		ui_map.set_map_visibility(false, map_time)

func on_gamemap_position_changed() -> void:
	if state == GameState.MOVE: 
		state = GameState.IDLE

func on_gamemap_visibility_changed() -> void:
	if state == GameState.MOVE or state == GameState.MAP: 
		if game_map.is_map_visible():
			state = GameState.IDLE
		else:
			state = GameState.MAP

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
