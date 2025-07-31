extends Node2D

@export var countdown : Control
@export var score_ui : Control
@export var collectable : PackedScene
@export var collectables_container : Node2D
@export var positions : Array[Marker2D]

func _ready() -> void:
	spawn_collectable()

func spawn_collectable() -> void:
	var collectable_instance : Area2D = collectable.instantiate()
	collectable_instance.global_position = choose_position()
	collectable_instance.connect("collected", _on_collected)
	collectables_container.call_deferred("add_child", collectable_instance)

func choose_position() -> Vector2:
	return positions.pick_random().global_position

func _on_collected() -> void:
	score_ui.emit_signal("scored")
	countdown.reset_timer()
	spawn_collectable()

func _on_player_lose() -> void:
	get_tree().reload_current_scene()
