extends Control

signal pressed_map

func make_button_invisible() -> void:
	show()
	modulate.a = 0.0

func _ready() -> void:
	$HBoxContainer/MapButton.connect("pressed", self, "on_map_pressed")
	if not visible:
		make_button_invisible()

func on_map_pressed() -> void:
	emit_signal("pressed_map")
