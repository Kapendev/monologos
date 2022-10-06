extends Spatial

const NOISE_TIME := 3
const STEP_TIME := 0.2
const STEP := Vector3(0, 0, -1.1)

onready var tween: Tween = $Tween
onready var camera: Camera = $Camera
onready var noise: Sprite3D = $Noise
onready var camera_start_translation: Vector3 = camera.translation

func _ready() -> void:
	tween.connect("tween_all_completed", self, "on_tween_all_completed")
	tween.interpolate_property(noise, "opacity", 1.0, 0.0, NOISE_TIME, Tween.TRANS_SINE)
	tween.start()

func move() -> void:
	if not tween.is_active():
		tween.interpolate_property(camera, "translation", camera.translation, camera.translation + STEP, STEP_TIME)
		tween.start()

func on_tween_all_completed() -> void:
	camera.translation = camera_start_translation
