extends Spatial

signal map_visibility_changed()
signal map_position_changed()

enum MapState {
	IDLE, MOVE, ANIMATION
}

const MOVE_VALUE := Vector3(0, 0, -0.815)
const SPIN_VALUE := Vector3(0, PI / 2.0, 0)

var state = 0

export var ground_material : SpatialMaterial

onready var tween: Tween = $Tween
onready var camera: Camera = $Camera
onready var noise: Sprite3D = $Camera/Noise
onready var target: TextureRect = $Target
onready var ground : MeshInstance = $Ground
onready var camera_start_translation: Vector3 = camera.translation

func _ready() -> void:
	tween.connect("tween_all_completed", self, "on_tween_all_completed")
	set_material(ground_material)

func is_active() -> bool:
	return tween.is_active()

func show_map(time: float) -> void:
	noise.show()
	tween.interpolate_property(
		noise, "opacity", 1.0, 0.0, time, Tween.TRANS_SINE
	)
	tween.start()
	state = MapState.ANIMATION

func hide_map(time: float) -> void:
	noise.show()
	tween.interpolate_property(
		noise, "opacity", 0.0, 1.0, time, Tween.TRANS_SINE
	)
	tween.start()
	state = MapState.ANIMATION

func set_map_visibility(value: bool, time: float) -> void:
	if value:
		show_map(time)
	else:
		hide_map(time)

func is_map_visible() -> bool:
	return not noise.visible

func set_material(material: SpatialMaterial) -> void:
	ground.set_surface_material(0, material)

func tweeen(prop: String, value: Vector3, time: float) -> void:
	# Target tween.
	tween.interpolate_property(
		target, "modulate",
		Lib.C0, target.modulate,
		time / 2.0, Tween.TRANS_SINE
	)
	tween.interpolate_property(
		target, "rect_scale",
		Vector2(1, 1), target.rect_scale,
		time / 2.0, Tween.TRANS_SINE
	)
	# Camera tween.
	tween.interpolate_property(
		camera, prop,
		camera.get(prop), value,
		time, Tween.TRANS_SINE
	)
	tween.start()
	state = MapState.MOVE

func dont_move(time: float) -> void:
	tween.interpolate_property(
		camera, "translation",
		camera.translation, camera.translation + MOVE_VALUE.rotated(Vector3.UP, camera.rotation.y) / 2.0,
		time / 2.0, Tween.TRANS_SINE
	)
	tween.interpolate_property(
		camera, "translation",
		camera.translation + MOVE_VALUE.rotated(Vector3.UP, camera.rotation.y) / 2.0, camera.translation,
		time / 2.0, Tween.TRANS_SINE,
		Tween.EASE_IN_OUT, time / 2.0
	)
	tween.start()
	state = MapState.MOVE

func move(time: float) -> void:
	tweeen(
		"translation",
		camera.translation + MOVE_VALUE.rotated(Vector3.UP, camera.rotation.y),
		time
	)

func spin_left_now() -> void:
	camera.rotation += SPIN_VALUE

func spin_right_now() -> void:
	camera.rotation -= SPIN_VALUE

func spin_left(time: float) -> void:
	tweeen("rotation", camera.rotation + SPIN_VALUE, time)
	
func spin_right(time: float) -> void:
	tweeen("rotation", camera.rotation - SPIN_VALUE, time)

func on_tween_all_completed() -> void:
	camera.translation = camera_start_translation
	if noise.opacity == 0.0:
		noise.hide()
	match state:
		MapState.MOVE:
			emit_signal("map_position_changed")
		MapState.ANIMATION:
			emit_signal("map_visibility_changed")
	state = MapState.IDLE
