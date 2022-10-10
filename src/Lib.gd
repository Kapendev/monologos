class_name Lib

const C1 := Color("#282328")
const C2 := Color("#545c7e")
const C3 := Color("#c56981")
const C4 := Color("#a3a29a")

class Grid:
	var size := Vector2()
	var actors := [] # Vector2
	var walls := [] # Vector2
	
	func _init(_size: Vector2):
		size = _size

	func is_inside(position: Vector2) -> bool:
		"""Returns true if position is inside grid."""
		return position.x >= 0.0 \
		and position.x < size.x \
		and position.y >= 0.0 \
		and position.y < size.y \

	func width() -> int:
		"""Returns the width of the grid."""
		return int(size.x) + 1
	
	func height() -> int:
		"""Returns the height of the grid."""
		return int(size.y) + 1
	
	func actor(id: int) -> Vector2:
		"""Returns an actors position."""
		return actors[id]
	
	func add_actor(position: Vector2) -> int:
		"""Adds a new actor to the grid. Returns the id of the created actor."""
		actors.append(position)
		return len(actors) - 1
	
	func remove_actor(id: int) -> void:
		"""Removes an actor from the grid."""
		actors[id].x = -1
	
	func move_actor(id: int, step: Vector2) -> void:
		"""Moves an actor in the grid."""
		var new: Vector2 = actors[id] + step
		if is_inside(new) and not new in walls:
			actors[id] = new
	
	func add_wall(position: Vector2) -> int:
		"""Adds a new wall to the grid. Returns the id of the created wall."""
		walls.append(position)
		return len(walls) - 1
	
	func remove_wall(id: int) -> void:
		"""Removes a wall from the grid."""
		walls[id].x = -1

static func new_grid(size: Vector2) -> Grid:
	"""Returns a new grid."""
	return Grid.new(size)
