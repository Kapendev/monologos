extends Control

onready var tween := $Tween
onready var music := $BGM

func _ready():
	$Boom.play()
	$Boom.connect("finished", self, "on_boom_fin")
	$Timer.connect("timeout", self, "on_timeout")
	$LineScreen.connect("hide_ended", self, "on_mutt")
	$AnimationPlayer.connect("animation_finished", self, "on_aim")

func on_boom_fin():
	$Timer.start()

func on_mutt():
	$AnimationPlayer.play("main")

func on_aim(_no):
	get_tree().change_scene("res://src/Main.tscn")

func on_timeout():
	$LineScreen.go_hide_mode()
