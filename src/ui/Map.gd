tool
extends Node2D

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
	# Draw the actors in the grid.
	for actor in grid.actors:
		if grid.is_inside(actor):
			draw_actor(actor)

func draw_h_line(x: int, y: int) -> void:
	"""Draws a horizontal line from the origin."""
	draw_line(
		Vector2(0, CELL_SIZE.y * y),
		Vector2(CELL_SIZE.x * x, CELL_SIZE.y * y),
		lib.GREY
	)

func draw_v_line(x: int, y: int) -> void:
	"""Draws a vertical line from the origin."""
	draw_line(
		Vector2(CELL_SIZE.x * x + 1, 0),
		Vector2(CELL_SIZE.x * x + 1, CELL_SIZE.y * y + 1),
		lib.PURPLE
)

func draw_actor(actor: Vector2) -> void:
	"""Draws an actor."""
	draw_circle(
		CELL_SIZE * actor + CELL_SIZE / 2,
		ACTOR_SIZE,
		lib.BLUE
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
