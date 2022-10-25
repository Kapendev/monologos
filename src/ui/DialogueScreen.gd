extends Control

signal ended

var index := 0
var start_mod := Lib.C4
var lines := []
onready var anim: AnimationPlayer = $Anim
onready var label: Label = $Label
onready var face: TextureRect = $Face
onready var tween: Tween = $Tween

var is_active := false
var can_next := false
var text_time := 1

func _ready() -> void:
	anim.connect("animation_finished", self, "on_animation_finished")
	if not visible:
		modulate.a = 0
		label.modulate.a = 0
		label.percent_visible = 0
		face.modulate.a = 0
		show()

func start(new_lines: Array, new_face := "") -> void:
	is_active = true
	lines = new_lines
	if not new_face.empty():
		face.texture = Lib.load_sprite(new_face)
	anim.play("start")

func end() -> void:
	is_active = true
	can_next = false
	anim.play("end")

func next() -> void:
	if can_next:
		if tween.is_active():
			label.modulate = start_mod
			label.percent_visible = 1
			tween.stop_all()
		else:
			index += 1
			if index >= len(lines):
				index = 0
				end()
			else:
				set_text(lines[index])

func set_text(text: String) -> void:
	label.text = text
	tween.stop_all()
	tween.interpolate_property(
		label, "modulate",
		Lib.C0, start_mod,
		text_time, Tween.TRANS_SINE
	)
	tween.interpolate_property(
		label, "percent_visible",
		0, 1,
		text_time, Tween.TRANS_SINE
	)
	tween.start()

func on_animation_finished(anim_name: String) -> void:
	if anim_name == "start":
		can_next = true
		set_text(lines[0])
	else:
		emit_signal("ended")
		modulate.a = 0
		label.modulate.a = 0
		label.percent_visible = 0
		face.modulate.a = 0
	is_active = false
