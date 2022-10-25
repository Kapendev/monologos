extends Control

signal pressed_up
signal pressed_down
signal pressed_left
signal pressed_right

var func_names := [
	"on_up_pressed",
	"on_down_pressed",
	"on_left_pressed",
	"on_right_pressed",
]

onready var buttons := [
	$HBoxContainer/VBoxContainer/UpButton,
	$HBoxContainer/VBoxContainer/DownButton,
	$HBoxContainer/LeftButton,
	$HBoxContainer/RightButton,
]

func _ready() -> void:
	for i in range(len(buttons)):
		buttons[i].connect("pressed", self, func_names[i])
	if not visible:
		show()
		modulate.a = 0.0

func activate() -> void:
	show()

func deactivate() -> void:
	hide()

func on_left_pressed() -> void:
	if visible:
		emit_signal("pressed_left")

func on_up_pressed() -> void:
	if visible:
		emit_signal("pressed_up")

func on_right_pressed() -> void:
	if visible:
		emit_signal("pressed_right")

func on_down_pressed() -> void:
	if visible:
		emit_signal("pressed_down")
