extends Control

signal pressed_spin_left
signal pressed_move
signal pressed_spin_right

func make_button_invisible() -> void:
	show()
	modulate.a = 0.0

func _ready() -> void:
	$HBoxContainer/SpinLeftButton.connect("pressed", self, "on_spin_left_pressed")
	$HBoxContainer/MoveButton.connect("pressed", self, "on_move_pressed")
	$HBoxContainer/SpinRightButton.connect("pressed", self, "on_spin_right_pressed")
	if not visible:
		make_button_invisible()

func on_spin_left_pressed() -> void:
	emit_signal("pressed_spin_left")

func on_move_pressed() -> void:
	emit_signal("pressed_move")

func on_spin_right_pressed() -> void:
	emit_signal("pressed_spin_right")
