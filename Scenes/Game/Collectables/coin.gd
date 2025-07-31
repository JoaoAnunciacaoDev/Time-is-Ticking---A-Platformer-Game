extends Area2D

signal collected

@export var feedback : PackedScene

func _on_body_entered(_body: Node2D) -> void:
	emit_signal("collected")
	var feedback_instance : Node2D = feedback.instantiate()
	feedback_instance.global_position = global_position
	get_tree().root.add_child(feedback_instance)
	queue_free()
