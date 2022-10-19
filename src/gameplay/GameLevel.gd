extends Node

enum GameState {
	IDLE, MAP, MOVE, ATTACK, TALK
}

var state := 0

var key_time := 0.1
var key_delay_time := 0.15
var move_time := 0.3
var map_time := 0.5
var start_time := 2.5

var grid: Lib.Grid
var player: Vector2
var player_direction := Vector2.UP

onready var game_map := $GameMap
onready var move_buttons := $MoveButtons
onready var ui_map := $UiMap
onready var qte_screen := $QteScreen
onready var state_timer := $StateTimer

func _ready():
	# Connect signals.
	move_buttons.connect("pressed_left", self, "on_pressed_left")
	move_buttons.connect("pressed_up", self, "on_pressed_up")
	move_buttons.connect("pressed_right", self, "on_pressed_right")
	move_buttons.connect("pressed_down", self, "on_pressed_down")
	state_timer.connect("timeout", self, "on_StateTimer_timeout")

	# Create data.
	randomize()
	grid = Lib.Grid.new(9, 9)
	player = grid.add_friend(Vector2(), 0, 0, "")
	for _i in range(randi() % 4):
		spin_player_left()
		game_map.spin_left_now()
	grid.add_enemy(Vector2(2, 2), 0, 0, "mon5|ddd")
	# Setup maps.
	ui_map.grid = grid
	game_map.show_map(start_time)
	change_state(GameState.MOVE, start_time)

func on_pressed_up() -> void:
	if state == GameState.MOVE:
		var target := player + player_direction
		if grid.exists(target) and not grid.is_wall(target):
			if grid.is_enemy(target):
				attack(target)
				change_state(GameState.ATTACK, move_time)
			elif grid.is_friend(target):
				talk(target)
				change_state(GameState.TALK, move_time)
			else:
				change_state(GameState.MOVE, move_time)
			game_map.move(move_time)
			player = grid.move_actor(player, target)
		else:
			game_map.dont_move(move_time)
			change_state(GameState.MOVE, move_time)
	elif state == GameState.ATTACK:
		if qte_screen.press_key("u"):
			print("sound effect")
		else:
			print("fail")

func on_pressed_down() -> void:
	if state == GameState.MOVE:
		game_map.set_map_visibility(false, map_time)
		ui_map.set_map_visibility(true, map_time)
		change_state(GameState.MAP, map_time)
	elif state == GameState.MAP:
		game_map.set_map_visibility(true, map_time)
		ui_map.set_map_visibility(false, map_time)
		change_state(GameState.MOVE, map_time)
	elif state == GameState.ATTACK:
		if qte_screen.press_key("d"):
			print("sound effect")
		else:
			print("fail")

func on_pressed_left() -> void:
	if state == GameState.MOVE:
		game_map.spin_left(move_time)
		spin_player_left()
		change_state(GameState.MOVE, move_time)
	elif state == GameState.ATTACK:
		if qte_screen.press_key("l"):
			print("sound effect")
		else:
			print("fail")

func on_pressed_right() -> void:
	if state == GameState.MOVE:
		game_map.spin_right(move_time)
		spin_player_right()
		change_state(GameState.MOVE, move_time)
	elif state == GameState.ATTACK:
		if qte_screen.press_key("r"):
			print("sound effect")
		else:
			print("fail")

func on_StateTimer_timeout() -> void:
	move_buttons.activate()

func attack(target: Vector2) -> void:
	var enemy_data := grid.get_actor_data(target)
	var enemy_name: String = enemy_data[0]
	var enemy_code: String = enemy_data[1]
	game_map.set_target_texture(Lib.load_sprite(enemy_name))
	qte_screen.create_keys(enemy_code, key_time, move_time - key_time + key_delay_time)

func talk(_target: Vector2) -> void:
	pass
 
func change_state(new: int, time := 0.0) -> void:
	state = new
	state_timer.start(time)
	move_buttons.deactivate()

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
