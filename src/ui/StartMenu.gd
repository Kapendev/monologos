extends Control

onready var start: Button = $VBoxContainer/Start
onready var exit: Button = $VBoxContainer/Exit
onready var line_screen: Control = $LineScreen

func _ready() -> void:
	line_screen.connect("hide_ended", self, "on_hide_ended")
	line_screen.connect("show_ended", self, "on_show_ended")
	start.connect("button_down", self, "_on_start_button_down")
	exit.connect("button_down", self, "_on_exit_button_down")
	start.grab_focus()
	line_screen.go_hide_mode()

func on_hide_ended() -> void:
	start.disabled = false
	exit.disabled = false

func on_show_ended() -> void:
	get_tree().change_scene("res://src/gameplay/GameLevel.tscn")

func _on_start_button_down() -> void:
	start.disabled = true
	exit.disabled = true
	line_screen.go_show_mode()

func _on_exit_button_down() -> void:
	pass
