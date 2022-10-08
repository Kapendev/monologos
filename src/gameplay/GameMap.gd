extends Spatial

const MOVE_VALUE := Vector3(0, 0, -1.1)
const SPIN_VALUE := Vector3(0, PI / 2.0, 0)

var move_time := 0.3
var spin_time := 0.3
var noise_time := 3

onready var tween: Tween = $Tween
onready var camera: Camera = $Camera
onready var noise: Sprite3D = $Noise
onready var target = $Camera/Target
onready var camera_start_translation: Vector3 = camera.translation

func _ready() -> void:
	noise.show()
	tween.connect("tween_all_completed", self, "on_tween_all_completed")
	tween.interpolate_property(
		noise, "opacity", 1.0, 0.0, noise_time, Tween.TRANS_SINE
	)
	tween.start()

func tweeen(node: Node, prop: String, value: Vector3, time: float) -> void:
	tween.interpolate_property(node, prop, node.get(prop), value, time, Tween.TRANS_SINE)
	tween.start()

func move() -> void:
	if not tween.is_active():
		tween.interpolate_property(
			target, "translation", target.translation.normalized() * 10, target.translation, move_time, Tween.TRANS_SINE
		)
		tweeen(camera, "translation", camera.translation + MOVE_VALUE.rotated(Vector3.UP, camera.rotation.y), move_time)

func spin_left() -> void:
	if not tween.is_active():
		tweeen(camera, "rotation", camera.rotation + SPIN_VALUE, spin_time)
	
func spin_right() -> void:
	if not tween.is_active():
		tweeen(camera, "rotation", camera.rotation - SPIN_VALUE, spin_time)

func on_tween_all_completed() -> void:
	camera.translation = camera_start_translation
	if noise.visible:
		noise.hide()
