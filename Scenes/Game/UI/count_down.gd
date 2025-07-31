extends Control

signal timer_is_over

@export var label : Label
@export var timer : Timer

func _ready() -> void:
	timer.start()

func _process(_delta: float) -> void:
	label.text = str(int(timer.time_left))

func reset_timer() -> void:
	timer.start()

func _on_timer_timeout() -> void:
	emit_signal("timer_is_over")
