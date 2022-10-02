extends Control

const lib := preload("res://src/Lib.gd")

export var can_start := false
var points := []

func _init():
	var width: int = ProjectSettings.get_setting("display/window/size/width")
	var height: int = ProjectSettings.get_setting("display/window/size/height")
	for i in range(height):
		points.append(Vector2(width, i))

func _process(_delta):
	if can_start:
		if len(points) == 0:
			set_process(false)
		else:
			update()
			points.remove(randi() % len(points))
			points.remove(randi() % len(points))

func _draw():
	for point in points:
		draw_h_line(point.x, point.y)

func draw_h_line(x: int, y: int) -> void:
	"""Draws a horizontal line from the origin."""
	draw_line(
		Vector2(0, y),
		Vector2(x, y),
		lib.BLACK
	)
