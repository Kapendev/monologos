extends Node

func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("ui_home"):
		OS.window_fullscreen = !OS.window_fullscreen
