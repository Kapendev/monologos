extends Node

enum GameState {
	IDLE, MAP, MOVE, ATTACK, EVENT, DEATH, WIN
}

var state := 0

var key_time := 0.1
var key_delay_time := 0.15
var move_time := 0.3
var spin_time := 0.4
var map_time := 0.5
var start_time := 2.5
var death_time := 5.5

var grid: Lib.GameGrid
var player: Lib.Actor
var player_dir := Vector2.UP

onready var game_map := $GameMap
onready var move_buttons := $MoveButtons
onready var ui_map := $UiMap
onready var qte_screen := $QteScreen
onready var state_timer := $StateTimer
onready var qte_timer := $QteScreen
onready var progress_timer := $ProgressTimer

func _ready():
	# Connect signals.
	move_buttons.connect("pressed_left", self, "on_pressed_left")
	move_buttons.connect("pressed_up", self, "on_pressed_up")
	move_buttons.connect("pressed_right", self, "on_pressed_right")
	move_buttons.connect("pressed_down", self, "on_pressed_down")
	state_timer.connect("timeout", self, "on_StateTimer_timeout")
	progress_timer.connect("timeout", self, "on_ProgressTimer_timeout")

	# Create data.
	randomize()
	grid = Lib.GameGrid.new(4, 4)
	player = Lib.new_actor(Vector2())
	grid.add_actor(player)
	grid.add_actor(Lib.new_actor(Vector2(2, 2), "mon2|ddd|4", "urdl"))
	grid.add_actor(Lib.new_event(Vector2(1, 0), ""))
	for _i in range(randi() % 4):
		spin_player_left()
		game_map.spin_left_now()
	# Setup maps.
	ui_map.grid = grid
	ui_map.dir.text = str_player_dir(false)
	game_map.show_map(start_time)
	change_state(GameState.MOVE, start_time)

func on_pressed_up() -> void:
	if state == GameState.MOVE:
		var old_pos := player.pos
		var actor := grid.move(player, str_player_dir())
		if actor == player:
			if old_pos == player.pos:
				game_map.dont_move(move_time)
			else:
				game_map.move(move_time)
			grid.update()
			change_state(state, move_time)
		else:
			if actor.is_event:
				event(actor)
			else:
				attack(actor)
			grid.eat(player, actor)
			game_map.move(move_time)
	elif state == GameState.ATTACK:
		if qte_screen.press_key(Lib.UP):
			check_qte_win()
		else:
			death()

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
		if qte_screen.press_key(Lib.DOWN):
			check_qte_win()
		else:
			death()

func on_pressed_left() -> void:
	if state == GameState.MOVE:
		game_map.spin_left(spin_time)
		spin_player_left()
		change_state(GameState.MOVE, spin_time)
	elif state == GameState.ATTACK:
		if qte_screen.press_key(Lib.LEFT):
			check_qte_win()
		else:
			death()

func on_pressed_right() -> void:
	if state == GameState.MOVE:
		game_map.spin_right(spin_time)
		spin_player_right()
		change_state(GameState.MOVE, spin_time)
	elif state == GameState.ATTACK:
		if qte_screen.press_key(Lib.RIGHT):
			check_qte_win()
		else:
			death()

func on_ProgressTimer_timeout() -> void:
	death()

func on_StateTimer_timeout() -> void:
	move_buttons.activate()
	if state == GameState.DEATH:
		# TODO: Change later.....!!!!
		get_tree().reload_current_scene()

func check_qte_win() -> void:
	if qte_screen.is_done():
		game_map.set_target_texture(null)
		progress_timer.stop()
		change_state(GameState.MOVE)

func death() -> void:
	progress_timer.stop()
	qte_screen.hide()
	game_map.death()
	change_state(GameState.DEATH, death_time)

func attack(actor: Lib.Actor) -> void:
	var data := actor.data()
	var aname: String = data[0]
	var acode: String = data[1]
	var atime := float(data[2])
	game_map.set_target_texture(Lib.load_sprite(aname))
	qte_screen.create_keys(acode, key_time, move_time - key_time + key_delay_time)
	progress_timer.start(atime, key_delay_time + key_time * 2)
	change_state(GameState.ATTACK, move_time)

func event(_target: Lib.Actor) -> void:
	change_state(GameState.EVENT, move_time)
 
func change_state(new: int, time := 0.0) -> void:
	state = new
	state_timer.start(time)
	move_buttons.deactivate()

func str_player_dir(is_dir:= true) -> String:
	var result := ""
	match player_dir:
		Vector2.UP:
			result = Lib.UP if is_dir else "N"
		Vector2.DOWN:
			result = Lib.DOWN if is_dir else "S"
		Vector2.LEFT:
			result = Lib.LEFT if is_dir else "W"
		Vector2.RIGHT:
			result = Lib.RIGHT if is_dir else "E"
	return result

func spin_player_left() -> void:
	match player_dir:
		Vector2.UP:
			player_dir = Vector2.LEFT
		Vector2.LEFT:
			player_dir = Vector2.DOWN
		Vector2.DOWN:
			player_dir = Vector2.RIGHT
		Vector2.RIGHT:
			player_dir = Vector2.UP
	ui_map.dir.text = str_player_dir(false)

func spin_player_right() -> void:
	match player_dir:
		Vector2.UP:
			player_dir = Vector2.RIGHT
		Vector2.RIGHT:
			player_dir = Vector2.DOWN
		Vector2.DOWN:
			player_dir = Vector2.LEFT
		Vector2.LEFT:
			player_dir = Vector2.UP
	ui_map.dir.text = str_player_dir(false)
