extends Control

var count := 0
var anim_time := 0.3
var hide_margin := -64
var start_margin := margin_top
var anim_margin := start_margin + 6

onready var label: Label = $Label
onready var tween: Tween = $Tween

func _ready() -> void:
	tween.connect("tween_all_completed", self, "on_tween_all_completed")

func add() -> void:
	count += 1
	label.text = String(count)
	tween.interpolate_property(
		label, "margin_top",
		start_margin, anim_margin,
		anim_time / 2.0, Tween.TRANS_SINE
	)
	tween.interpolate_property(
		label, "margin_top",
		anim_margin, start_margin,
		anim_time / 2.0, Tween.TRANS_SINE,
		Tween.EASE_IN_OUT, anim_time / 2.0
	)
	tween.start()

func is_active() -> bool:
	return tween.is_active()

func show_counter(time: float) -> void:
	show()
	tween.interpolate_property(
		label, "margin_top",
		hide_margin, start_margin,
		time, Tween.TRANS_SINE
	)
	tween.start()

func hide_counter(time: float) -> void:
	show()
	tween.interpolate_property(
		label, "margin_top",
		start_margin, hide_margin,
		time, Tween.TRANS_SINE
	)
	tween.start()

func set_counter_visibility(value: bool, time: float) -> void:
	if value:
		show_counter(time)
	else:
		hide_counter(time)

func is_counter_visible() -> bool:
	return visible

func on_tween_all_completed() -> void:
	set_visible(label.margin_top != hide_margin)
