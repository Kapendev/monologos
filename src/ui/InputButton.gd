extends Button

export var is_active := true setget set_is_active
export var key := ""

func _ready():
	set_process_input(not key.empty())

func _input(event):
	if is_active and event.is_action_pressed(key):
		emit_signal("pressed")

func set_is_active(new: bool) -> void:
	is_active = new
	disabled = new
