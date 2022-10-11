extends Button

export var key := ""

func _ready():
	set_process_input(not key.empty())

func _input(event):
	if event.is_action_pressed(key):
		emit_signal("pressed")
