tool
extends Control

signal show_ended
signal hide_ended

enum Mode {
	IDLE,
	SHOW,
	HIDE,
}

const lib := preload("res://src/Lib.gd")

export var width := 320 setget set_width
export var height := 180 setget set_height
export var hide_speed := 3
export var show_speed := 3
var mode: int = Mode.IDLE
var points := []
var removed_points := []

func _ready() -> void:
	if Engine.editor_hint:
		set_process(false)
	else:
		create_points()

func _process(_delta) -> void:
	match mode:
		Mode.IDLE:
			pass
		Mode.SHOW:
			update()
			reconstruct_points(show_speed)
			if len(removed_points) == 0:
				go_idle_mode()
				emit_signal("show_ended")
		Mode.HIDE:
			update()
			remove_points(hide_speed)
			if len(points) == 0:
				go_idle_mode()
				emit_signal("hide_ended")

func _draw() -> void:
	if Engine.editor_hint:
		draw_rect(Rect2(0, 0, width, height), Color(1, 1, 1, 0.2))
	else:
		for point in points:
			draw_h_line(point)

func draw_h_line(point: Vector2) -> void:
	"""Draws a horizontal line from the origin."""
	draw_line(
		Vector2(0, point.y),
		point,
		lib.BLACK
	)

func create_points() -> void:
	for i in range(height):
		points.append(Vector2(width, i))

func remove_points(n: int) -> void:
	for _i in range(n):
		if len(points) != 0:
			removed_points.append(points.pop_at(randi() % len(points)))

func reconstruct_points(n: int) -> void:
	for _i in range(n):
		if len(removed_points) != 0:
			points.append(removed_points.pop_back())

func go_idle_mode() -> void:
	if mode == Mode.HIDE:
		hide()
	else:
		show()
	mode = Mode.IDLE

func go_show_mode() -> void:
	show()
	mode = Mode.SHOW

func go_hide_mode() -> void:
	show()
	mode = Mode.HIDE

func set_width(new: int) -> void:
	width = new
	rect_size.x = width
	update()

func set_height(new: int) -> void:
	height = new
	rect_size.y = height
	update()
