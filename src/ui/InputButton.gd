extends Button

export var is_active := true
export var key := ""

func _ready():
	set_process_input(is_active and not key.empty())

func _input(event):
	if event.is_action_pressed(key):
		emit_signal("pressed")
