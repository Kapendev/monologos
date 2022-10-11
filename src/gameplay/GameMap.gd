extends Spatial

const MOVE_VALUE := Vector3(0.0, 0.0, -1.1)
const SPIN_VALUE := Vector3(0.0, PI / 2.0, 0.0)

var move_time := 0.3
var spin_time := 0.3

onready var tween: Tween = $Tween
onready var camera: Camera = $Camera
onready var noise: Sprite3D = $Camera/Noise
onready var target: Sprite3D = $Camera/Target
onready var camera_start_translation: Vector3 = camera.translation

func _ready() -> void:
	tween.connect("tween_all_completed", self, "on_tween_all_completed")
	noise.show()

func is_active() -> bool:
	return tween.is_active()

func show_map(time: float) -> void:
	if not tween.is_active():
		noise.show()
		tween.interpolate_property(
			noise, "opacity", 1.0, 0.0, time, Tween.TRANS_SINE
		)
		tween.start()

func hide_map(time: float) -> void:
	if not tween.is_active():
		noise.show()
		tween.interpolate_property(
			noise, "opacity", 0.0, 1.0, time, Tween.TRANS_SINE
		)
		tween.start()

func set_map_visibility(value: bool, time: float) -> void:
	if value:
		show_map(time)
	else:
		hide_map(time)

func is_map_visible() -> bool:
	return not noise.visible

func tweeen(prop: String, value: Vector3, time: float) -> void:
	tween.interpolate_property(
		target, "translation",
		target.translation.normalized() * 10.0, target.translation,
		move_time, Tween.TRANS_SINE
	)
	tween.interpolate_property(
		camera, prop,
		camera.get(prop), value,
		time, Tween.TRANS_SINE
	)
	tween.start()

func dont_move() -> void:
	if not tween.is_active():
		tween.interpolate_property(
			camera, "translation",
			camera.translation, camera.translation + MOVE_VALUE.rotated(Vector3.UP, camera.rotation.y) / 2.0,
			move_time / 2.0, Tween.TRANS_SINE
		)
		tween.interpolate_property(
			camera, "translation",
			camera.translation + MOVE_VALUE.rotated(Vector3.UP, camera.rotation.y) / 2.0, camera.translation,
			move_time / 2.0, Tween.TRANS_SINE,
			Tween.EASE_IN_OUT, move_time / 2.0
		)
		tween.start()

func move() -> void:
	if not tween.is_active():
		tweeen(
			"translation",
			camera.translation + MOVE_VALUE.rotated(Vector3.UP, camera.rotation.y),
			move_time
		)

func spin_left() -> void:
	if not tween.is_active():
		tweeen("rotation", camera.rotation + SPIN_VALUE, spin_time)
	
func spin_right() -> void:
	if not tween.is_active():
		tweeen("rotation", camera.rotation - SPIN_VALUE, spin_time)

func on_tween_all_completed() -> void:
	camera.translation = camera_start_translation
	if noise.opacity == 0.0:
		noise.hide()
