class_name Lib

const SPRITES_PATH = "res://assets/sprites/{}.png"
const MUSIC_PATH = "res://assets/music/{}.ogg"
const LEVEL_PATH = "res://src/levels/{}.tscn"
const SPLIT_PAT = "|"

const C0 := Color(0, 0, 0, 0)
const C9 := Color(1, 1, 1, 1)
const C1 := Color("#211f1f")
const C2 := Color("#372c38")
const C3 := Color("#7a7272")
const C4 := Color("#ababab")

const UP = "u"
const DOWN = "d"
const LEFT = "l"
const RIGHT = "r"

class Grid:
	var w: int
	var h: int
	var cells: Array
	
	func _init(_w: int, _h: int) -> void:
		w = _w
		h = _h
		cells = []
		for _i in range(w * h):
			cells.append(0)
	
	func id(vec: Vector2) -> int:
		return int(vec.y) * w + int(vec.x)
	
	func vec(id: int) -> Vector2:
		# warning-ignore:integer_division
		return Vector2(id % w, id / w)
	
	func cell(id: int) -> int:
		return cells[id]
	
	func cellv(vec: Vector2) -> int:
		return cells[id(vec)]
	
	func change(id: int, value: int) -> void:
		cells[id] = value
	
	func changev(vec: Vector2, value: int) -> void:
		cells[id(vec)] = value
	
	func swap(id1: int, id2: int) -> void:
		change(id1, cell(id1) + cell(id2))
		change(id2, cell(id1) - cell(id2))
		change(id1, cell(id1) - cell(id2))
	
	func swapv(vec1: Vector2, vec2: Vector2) -> void:
		swap(id(vec1), id(vec2))
	
	func is_inside(vec: Vector2) -> bool:
		return vec.x >= 0 \
		and vec.x < w \
		and vec.y >= 0 \
		and vec.y < h \

class Actor:
	var is_event: bool
	var id: int
	var counter: int
	var moveset: String
	var info: String
	var pos: Vector2
	
	func _init(_is_event: bool, _pos: Vector2, _info: String, _moveset := "") -> void:
		is_event = _is_event
		moveset = _moveset
		info = _info
		pos = _pos
		counter = 0
		id = 0
	
	func data() -> Array:
		return info.split(SPLIT_PAT) as Array
	
	func die() -> void:
		pos.x = - 1
		moveset = ""
	
static func new_event(pos: Vector2, info: String) -> Actor:
	return Actor.new(true, pos, info)

static func new_actor(pos: Vector2, moveset := "", info := "") -> Actor:
	return Actor.new(false, pos, info, moveset)

class GameGrid extends Grid:
	var actors := []
	
	func _init(_w: int, _h: int).(_w, _h) -> void:
		pass # What the...
	
	func add_actor(actor: Actor) -> void:
		actors.append(actor)
		actor.id = len(actors)
		changev(actor.pos, actor.id)
	
	func add_wall(pos: Vector2) -> void:
		changev(pos, -1)
	
	func has_actor(pos: Vector2) -> bool:
		var value := cellv(pos)
		return value > 0 and value <= len(actors)
	
	func has_wall(pos: Vector2) -> bool:
		return cellv(pos) == -1
	
	func move(actor: Actor, dir: String) -> Actor:
		var new_pos := actor.pos
		match dir:
			UP:
				new_pos.y -= 1
			DOWN:
				new_pos.y += 1
			LEFT:
				new_pos.x -= 1
			RIGHT:
				new_pos.x += 1
		if is_inside(new_pos) and not has_wall(new_pos):
			if has_actor(new_pos):
				return actors[cellv(new_pos) - 1]
			else:
				swapv(actor.pos, new_pos)
				actor.pos = new_pos
		return actor
	
	func eat(actor1: Actor, actor2: Actor) -> void:
		changev(actor2.pos, 0)
		swapv(actor1.pos, actor2.pos)
		actor1.pos = actor2.pos
		actor2.die()
	
	func update() -> void:
		for actor in actors:
			if not actor.moveset.empty():
				move(actor, actor.moveset[actor.counter])
				actor.counter += 1
				if actor.counter >= len(actor.moveset):
					actor.counter = 0

static func load_sprite(path: String) -> StreamTexture:
	return load(SPRITES_PATH.format([path], "{}")) as StreamTexture

static func load_music(_path: String) -> AudioStream:
	return preload("res://assets/music/wind.wav")

static func load_level(path: String) -> String:
	return LEVEL_PATH.format([path], "{}")

static func random_scale(old_scale: float, base_scale := 1.0) -> float:
	var new_scale := old_scale
	while new_scale == old_scale:
		new_scale = rand_range(base_scale - 0.05, base_scale + 0.05)
	return new_scale
