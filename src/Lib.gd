class_name Lib

const SPRITES_PATH = "res://assets/sprites/{}.png"
const SPLIT_PAT = "|"
const C0 := Color(0, 0, 0, 0)
const C1 := Color("#211f1f")
const C2 := Color("#372c38")
const C3 := Color("#6e6e6e")
const C4 := Color("#ababab")

enum ActorType {
	NONE, WALL, FRIEND, ENEMY
}

enum MoveType {
	UP, DOWN, LEFT, RIGHT,
}

class Actor:
	var type: int
	var hp: int
	var ap: int
	var info: String
	var moves: Array # int
	
	func _init(_type: int, _hp: int, _ap: int, _moves := [], _info := "") -> void:
		type = _type
		hp = _hp
		ap = _ap
		moves = _moves
		info = _info
	
	func change(_type: int, _hp: int, _ap: int, _moves: Array, _info: String) -> void:
		type = _type
		hp = _hp
		ap = _ap
		moves = _moves
		info = _info
	
	func change_with(actor: Actor) -> void:
		type = actor.type
		hp = actor.hp
		ap = actor.ap
		moves = actor.moves
		info = actor.info
	
	func swap_with(actor: Actor) -> void:
		var temp := Actor.new(type, hp, ap, moves, info)
		change_with(actor)
		actor.change_with(temp)

class Grid:
	var width: int
	var height: int
	var actors := []
	
	func __new_empty(type: int) -> Actor:
		return Actor.new(type, 0, 0, [])
	
	func __new_none() -> Actor:
		return __new_empty(ActorType.NONE)
	
	func __new_wall() -> Actor:
		return __new_empty(ActorType.WALL)
	
	func __new_friend() -> Actor:
		return __new_empty(ActorType.FRIEND)
	
	func __new_enemy() -> Actor:
		return __new_empty(ActorType.ENEMY)
	
	func _init(_width: int, _height: int):
		width = _width
		height = _height
		for _y in range(height):
			for _x in range(width):
				actors.append(__new_none())
	
	func index(position: Vector2) -> int:
		return int(floor(position.y)) * width + int(floor(position.x))
	
	func exists(position: Vector2) -> bool:
		return position.x >= 0 \
		and position.x < width \
		and position.y >= 0 \
		and position.y < height \
	
	func add_none(position: Vector2) -> Vector2:
		var actor: Actor = actors[index(position)]
		actor.change(ActorType.NONE, 0, 0, [], "")
		return position
	
	func add_wall(position: Vector2) -> Vector2:
		var actor: Actor = actors[index(position)]
		actor.change(ActorType.WALL, 0, 0, [], "")
		return position
	
	func add_friend(position: Vector2, hp: int, ap: int, info: String, moves := []) -> Vector2:
		var actor: Actor = actors[index(position)]
		actor.change(ActorType.FRIEND, hp, ap, moves, info)
		return position
	
	func add_enemy(position: Vector2, hp: int, ap: int, info: String, moves := []) -> Vector2:
		var actor: Actor = actors[index(position)]
		actor.change(ActorType.ENEMY, hp, ap, moves, info)
		return position
	
	func is_none(position: Vector2) -> bool:
		return actors[index(position)].type == ActorType.NONE
	
	func is_wall(position: Vector2) -> bool:
		return actors[index(position)].type == ActorType.WALL
	
	func is_friend(position: Vector2) -> bool:
		return actors[index(position)].type == ActorType.FRIEND
	
	func is_enemy(position: Vector2) -> bool:
		return actors[index(position)].type == ActorType.ENEMY
	
	func move_actor(position: Vector2, new_position: Vector2) -> Vector2:
		var actor: Actor = actors[index(position)]
		var new_actor: Actor = actors[index(new_position)]
		new_actor.change_with(actor)
		add_none(position)
		return new_position
	
	func get_actor_data(position: Vector2) -> Array:
		return actors[index(position)].info.split(SPLIT_PAT)

static func load_sprite(path: String) -> StreamTexture:
	return load(SPRITES_PATH.format([path], "{}")) as StreamTexture
