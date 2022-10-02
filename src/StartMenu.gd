extends Control

onready var start: Button = $MarginContainer/VBoxContainer/Start
onready var options: Button = $MarginContainer/VBoxContainer/Options
onready var exit: Button = $MarginContainer/VBoxContainer/Exit

func _ready():
	start.grab_focus()
