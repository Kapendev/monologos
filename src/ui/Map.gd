tool
extends Control

enum Mode {
	IDLE,
	SHOW,
	HIDE,
}

const lib := preload("res://src/Lib.gd")
const CELL_SIZE := Vector2(16, 16)
const ACTOR_SIZE := 4

export(int, 1, 50) var width := 1 setget set_width
export(int, 1, 50) var height := 1 setget set_height
var grid := lib.new_grid(Vector2(width, height))

func _draw() -> void:
	# Draw the grid.
	for i in range(grid.height()):
		draw_h_line(grid.width() - 1, i)
	for i in range(grid.width()):
		draw_v_line(i, grid.height() - 1)
	# Draw the actors and walls in the grid.
	for actor in grid.actors:
		if grid.is_inside(actor):
			draw_actor(actor)
	for wall in grid.walls:
		if grid.is_inside(wall):
			draw_wall(wall)

func draw_h_line(x: int, y: int) -> void:
	"""Draws a horizontal line from the origin."""
	var x_offset := -CELL_SIZE.x * width / 2.0
	var y_offset := -CELL_SIZE.y * height / 2.0
	draw_line(
		Vector2(x_offset, y_offset + CELL_SIZE.y * y),
		Vector2(x_offset + CELL_SIZE.x * x, y_offset + CELL_SIZE.y * y),
		lib.PURPLE
	)

func draw_v_line(x: int, y: int) -> void:
	"""Draws a vertical line from the origin."""
	var x_offset := -CELL_SIZE.x * width / 2.0
	var y_offset := -CELL_SIZE.y * height / 2.0
	draw_line(
		Vector2(x_offset + CELL_SIZE.x * x + 1, y_offset),
		Vector2(x_offset + CELL_SIZE.x * x + 1, y_offset + CELL_SIZE.y * y + 1),
		lib.PURPLE
)

func draw_actor(actor: Vector2) -> void:
	var x_offset := -CELL_SIZE.x * width / 2.0
	var y_offset := -CELL_SIZE.y * height / 2.0
	var offset := Vector2(x_offset, y_offset)
	"""Draws an actor."""
	draw_circle(
		offset + CELL_SIZE * actor + CELL_SIZE / 2,
		ACTOR_SIZE,
		lib.RED
	)

func draw_wall(wall: Vector2) -> void:
	var x_offset := -CELL_SIZE.x * width / 2.0 
	var y_offset := -CELL_SIZE.y * height / 2.0
	var offset := Vector2(x_offset, y_offset)
	"""Draws an actor."""
	draw_rect(
		Rect2(
			offset + CELL_SIZE * wall + Vector2(1, 1),
			CELL_SIZE - Vector2(1, 1)
		),
		lib.PURPLE
	)

func set_width(new) -> void:
	"""Used for updating the editor grid."""
	width = new
	grid.size.x = width
	update()

func set_height(new) -> void:
	"""Used for updating the editor grid."""
	height = new
	grid.size.y = height
	update()
