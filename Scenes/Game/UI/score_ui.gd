extends Control

signal scored

@export var label : Label

var score : int = 0

func _ready() -> void:
	update_score()

func update_score() -> void:
	label.text = "Score: " + str(score)

func sum_score() -> void:
	score += 1
	update_score()

func _on_scored() -> void:
	sum_score()
