extends Control

signal pressed_left
signal pressed_up
signal pressed_right
signal pressed_down

func make_button_invisible() -> void:
	show()
	modulate.a = 0.0

func _ready() -> void:
	$VBoxContainer/Box2/LeftButton.connect("pressed", self, "on_left_pressed")
	$VBoxContainer/Box1/UpButton.connect("pressed", self, "on_up_pressed")
	$VBoxContainer/Box2/RightButton.connect("pressed", self, "on_right_pressed")
	$VBoxContainer/Box2/DownButton.connect("pressed", self, "on_down_pressed")
	if not visible:
		make_button_invisible()

func on_left_pressed() -> void:
	emit_signal("pressed_left")

func on_up_pressed() -> void:
	emit_signal("pressed_up")

func on_right_pressed() -> void:
	emit_signal("pressed_right")

func on_down_pressed() -> void:
	emit_signal("pressed_down")
