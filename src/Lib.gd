const BLACK := Color("#282328")
const YELLOW := Color(0.93, 0.92, 0.73)
const PURPLE := Color(0.45, 0.47, 0.71)
const PINK := Color(0.67, 0.44, 0.69)
const GREY := Color(0.43, 0.43, 0.43)
const GREEN := Color(0.65, 0.87, 0.58)
const RED := Color(0.66, 0.43, 0.4)
const BLUE := Color(0.61, 0.8, 0.84)

class Grid:
	var size := Vector2()
	var actors := [] # Vector2
	var walls := [] # Vector2
	
	func _init(_size: Vector2):
		size = _size

	func is_inside(position: Vector2) -> bool:
		"""Returns true if position is inside grid."""
		return position >= Vector2.ZERO and position < size

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
	
	func move_actor(id: int, position: Vector2) -> void:
		"""Moves an actor in the grid."""
		if is_inside(position) and not position in walls:
			actors[id] = position
	
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
