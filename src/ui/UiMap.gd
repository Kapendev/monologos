extends Control

const CELL_SIZE := Vector2(14.0, 14.0)
const ACTOR_SIZE := 4
const MAP_OFFSET := 200

var grid: Lib.Grid
var blacks := [] # Vector2
var win := Vector2(-1, -1)

onready var tween: Tween = $Tween
onready var dir: Label = $Dir

func _ready() -> void:
	tween.connect("tween_all_completed", self, "on_tween_all_completed")
	margin_top = get_viewport_rect().size.y
	dir.modulate = Lib.C4
	hide()

func _draw() -> void:
	# Draw the grid.
	for i in range(grid.h + 1):
		draw_h_line(grid.w, i)
	for i in range(grid.w + 1):
		draw_v_line(i, grid.h)
	# Draw the actors and walls in the grid.
	for y in range(grid.h):
		for x in range(grid.w):
			var position := Vector2(x, y)
			if position == win:
				draw_win(position)
			elif position in blacks:
				draw_black(position)
			elif grid.cellv(position) == -1:
				draw_wall(position)
			elif grid.cellv(position) > 0:
				draw_actor(position)

func is_active() -> bool:
	return tween.is_active()

func show_map(time: float) -> void:
	var viewport_height := get_viewport_rect().size.y
	show()
	tween.interpolate_property(
		self, "margin_top", viewport_height, 0.0, time, Tween.TRANS_SINE
	)
	tween.interpolate_property(
		self, "modulate", Lib.C0, Lib.C9, time, Tween.TRANS_SINE
	)
	tween.start()

func hide_map(time: float) -> void:
	var viewport_height := get_viewport_rect().size.y
	show()
	tween.interpolate_property(
		self, "margin_top", 0.0, viewport_height, time, Tween.TRANS_SINE
	)
	tween.interpolate_property(
		self, "modulate", Lib.C9, Lib.C0, time, Tween.TRANS_SINE
	)
	tween.start()

func set_map_visibility(value: bool, time: float) -> void:
	if value:
		show_map(time)
	else:
		hide_map(time)

func is_map_visible() -> bool:
	return visible

func x_offset() -> float:
	return -CELL_SIZE.x * (grid.w / 2.0)

func y_offset() -> float:
	return -CELL_SIZE.y * (grid.h / 2.0)

func draw_h_line(x: int, y: int) -> void:
	draw_line(
		Vector2(x_offset(), y_offset() + CELL_SIZE.y * y),
		Vector2(x_offset() + CELL_SIZE.x * x, y_offset() + CELL_SIZE.y * y),
		Lib.C3
	)

func draw_v_line(x: int, y: int) -> void:
	draw_line(
		Vector2(x_offset() + CELL_SIZE.x * x + 1.0, y_offset()),
		Vector2(x_offset() + CELL_SIZE.x * x + 1.0, y_offset() + CELL_SIZE.y * y + 1.0),
		Lib.C3
)

func draw_wall(wall: Vector2) -> void:
	draw_rect(
		Rect2(
			Vector2(x_offset(), y_offset()) + CELL_SIZE * wall + Vector2(1.0, 1.0),
			CELL_SIZE - Vector2(1.0, 1.0)
		),
		Lib.C3
	)

func draw_black(black: Vector2) -> void:
	draw_rect(
		Rect2(
			Vector2(x_offset(), y_offset()) + CELL_SIZE * black + Vector2(1.0, 1.0),
			CELL_SIZE - Vector2(1.0, 1.0)
		),
		Lib.C2
	)

func draw_win(black: Vector2) -> void:
	draw_rect(
		Rect2(
			Vector2(x_offset(), y_offset()) + CELL_SIZE * black + Vector2(1.0, 1.0),
			CELL_SIZE - Vector2(1.0, 1.0)
		),
		Lib.C4
	)

func draw_actor(actor: Vector2) -> void:
	draw_circle(
		Vector2(x_offset(), y_offset()) + CELL_SIZE * actor + CELL_SIZE / 2.0,
		ACTOR_SIZE,
		Lib.C4
	)

func on_tween_all_completed() -> void:
	var viewport_height = get_viewport_rect().size.y
	set_visible(margin_top != viewport_height)
