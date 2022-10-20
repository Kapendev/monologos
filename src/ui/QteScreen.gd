extends Control

const MAX_KEY_COUNT := 7

const UP = "u"
const DOWN = "d"
const LEFT = "l"
const RIGHT = "r"

const A1_RES := preload("res://assets/sprites/arrowkey1.png")
const A2_RES := preload("res://assets/sprites/arrowkey2.png")

onready var boxes: VBoxContainer = $Boxes
onready var base_key: TextureRect = $ArrowKey
onready var tween: Tween = $Tween
onready var hit_sound: AudioStreamPlayer = $HitSound

func play_sound(sound: AudioStreamPlayer) -> void:
	sound.pitch_scale = Lib.random_scale(sound.pitch_scale)
	sound.play()

func is_active() -> bool:
	return tween.is_active()

func is_done() -> bool:
	for box in boxes.get_children():
		for child in box.get_children():
			if child.modulate.a != 0:
				return false
	return true

func press_key(code: String) -> bool:
	"""Returns true if the current code is visible."""
	for box in boxes.get_children():
		for child in box.get_children():
			if child.visible and child.modulate.a != 0:
				if child.texture == A1_RES and child.flip_v == true:
					if code == "u":
						child.modulate.a = 0
						play_sound(hit_sound)
					return child.modulate.a == 0
				elif child.texture == A1_RES:
					if code == "d":
						child.modulate.a = 0
						play_sound(hit_sound)
					return child.modulate.a == 0
				elif child.texture == A2_RES and child.flip_h == true:
					if code == "l":
						child.modulate.a = 0
						play_sound(hit_sound)
					return child.modulate.a == 0
				elif child.texture == A2_RES:
					if code == "r":
						child.modulate.a = 0
						play_sound(hit_sound)
					return child.modulate.a == 0
	return false

func remove_keys() -> void:
	for box in boxes.get_children():
		for child in box.get_children():
			if child.visible:
				child.queue_free()

func create_keys(code: String, time: float, delay := 0.0) -> void:
	remove_keys()
	var box_id := 0
	var box := boxes.get_child(box_id)
	for c in code:
		var key: TextureRect = base_key.duplicate()
		match c:
			UP:
				key.texture = A1_RES
				key.flip_v = true
			DOWN:
				key.texture = A1_RES
			LEFT:
				key.texture = A2_RES
				key.flip_h = true
			RIGHT:
				key.texture = A2_RES
		box.add_child(key)
		if box.get_child_count() == MAX_KEY_COUNT:
			box_id += 1
			box = boxes.get_child(box_id)
	for child in boxes.get_children():
		child.modulate.a = 0
		tween.interpolate_property(
			child, "modulate",
			child.modulate, Color.white,
			time, Tween.TRANS_SINE,
			Tween.EASE_IN_OUT, delay
		)
		tween.start()
