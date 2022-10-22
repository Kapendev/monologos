extends Control

signal timeout

var color := Lib.C3
var time_buffer := 1.0

onready var timer: Timer = $Timer
onready var delay: Timer = $Delay
onready var rect: ColorRect = $ColorRect

func _ready():
	timer.connect("timeout", self, "on_Timer_timeout")
	delay.connect("timeout", self, "on_Delay_timeout")
	rect.color = color

func _process(_delta):
	rect.rect_scale.x = timer.time_left / timer.wait_time

func start(time_time: float, delay_time: float) -> void:
	time_buffer = time_time
	delay.start(delay_time)

func stop() -> void:
	timer.stop()

func on_Delay_timeout() -> void:
	show()
	set_process(true)
	rect.rect_scale.x = 1
	timer.start(time_buffer)

func on_Timer_timeout() -> void:
	hide()
	set_process(false)
	emit_signal("timeout")
