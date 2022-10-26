extends Node

var buttons_disabled = false

func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if OS.window_fullscreen:
			OS.window_fullscreen = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			OS.window_fullscreen = true
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
