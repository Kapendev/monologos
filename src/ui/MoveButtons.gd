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
	$VBoxContainer/Box1/UpButton,
	$VBoxContainer/Box2/DownButton,
	$VBoxContainer/Box2/LeftButton,
	$VBoxContainer/Box2/RightButton,
]

func _ready() -> void:
	for i in range(len(buttons)):
		buttons[i].connect("pressed", self, func_names[i])
	if not visible:
		show()
		modulate.a = 0.0

func activate() -> void:
	for button in buttons:
		button.set_is_active(true)

func deactivate() -> void:
	for button in buttons:
		button.set_is_active(false)

func on_left_pressed() -> void:
	emit_signal("pressed_left")

func on_up_pressed() -> void:
	emit_signal("pressed_up")

func on_right_pressed() -> void:
	emit_signal("pressed_right")

func on_down_pressed() -> void:
	emit_signal("pressed_down")
