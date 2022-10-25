extends Node

func _ready():
	$MoveButtons.connect("pressed_up", self, "on_pressed_up")
	$StartTimer.connect("timeout", self, "on_stimeout")
	$EndTimer.connect("timeout", self, "on_etimeout")
	$LineScreen.connect("show_ended", self, "on_show_ended")

func on_pressed_up():
	$LineScreen.go_show_mode()

func on_stimeout():
	$LineScreen.go_hide_mode()

func on_etimeout():
	get_tree().change_scene("res://src/levels/Level1.tscn")

func on_show_ended():
	$EndTimer.start()
