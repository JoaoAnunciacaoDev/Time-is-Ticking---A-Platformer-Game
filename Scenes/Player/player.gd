@icon("res://Assets/Character/chickenIcon.png")
extends CharacterBody2D

signal dead

@export_category("Movement Stats")
@export var speed : int
@export var gravity : float

@export_category("Jump and Fall")
@export var jump_force : float
@export var jump_count_max : int
@export var jump_count : int
@export var jump_buffer : float
@export var jump_buffer_time : float
@export var max_fall_speed : float
@export var corner_correction_vertical : float
@export var corner_correction_horizontal : float
@export var coyote_timer : Timer
@export var was_on_floor : bool = false

@export_category("Animation")
@export var anim : AnimatedSprite2D
@export var animation_player : AnimationPlayer

@export var state_machine : Node
@export var ledge_detector_right : RayCast2D
@export var ledge_detector_left : RayCast2D
@export var floor_detector_right : RayCast2D
@export var floor_detector_left : RayCast2D

var is_correcting_ledge : bool = false
var is_dead : bool = false

func _unhandled_input(event: InputEvent) -> void:
	state_machine._on_input(event)

func _physics_process(delta: float) -> void:
	if is_dead: return
	
	active_gravity(gravity, delta)

	minus_jump_buffer(delta)

	corner_correction()
	
	reset_correcting_ledge()

	check_was_on_floor()

	move_and_slide()

func move(input_axis : int) -> void:
	velocity.x = speed * input_axis

func jump() -> void:
	velocity.y = -jump_force
	minus_jump_count()
	play_squash_n_stretch()

func can_jump() -> bool:
	return jump_count > 0 or not coyote_timer.is_stopped()

func check_was_on_floor() -> void:
	if was_on_floor and not is_on_floor() and velocity.y >= 0:
		coyote_timer.start()
	was_on_floor = is_on_floor()

func minus_jump_count() -> void:
	if jump_count > 0:
		jump_count -= 1

func reset_jump_count() -> void:
	jump_count = jump_count_max

func set_jump_buffer() -> void:
	jump_buffer = jump_buffer_time

func is_jump_buffering() -> bool:
	return jump_buffer > 0

func reset_jump_buffer() -> void:
	jump_buffer = 0

func minus_jump_buffer(delta : float) -> void:
	if jump_buffer > 0:
			jump_buffer -= delta

func cut_velocity() -> void:
	velocity.y *= 0.25

func active_gravity(accel : float, delta : float) -> void:
	if velocity.y <= max_fall_speed:
		velocity.y += accel * delta

func play_squash_n_stretch() -> void:
	animation_player.play("squash_n_stretch")

func flip_sprite(input_axis : int) -> void:
	match input_axis:
		1:
			anim.flip_h = true
		-1:
			anim.flip_h = false

func corner_correction() -> void:
	if is_correcting_ledge: return
	
	if velocity.y < 0 and is_on_wall():
		var collision = get_last_slide_collision()
		if collision:
			if collision.get_normal().x < 0 and not ledge_detector_right.is_colliding():
				velocity.y = -corner_correction_vertical
				velocity.x = corner_correction_vertical
				is_correcting_ledge = true
			if collision.get_normal().x > 0 and not ledge_detector_left.is_colliding():
				velocity.y = -corner_correction_vertical
				velocity.x = -corner_correction_vertical
				is_correcting_ledge = true

	if is_on_floor() and is_on_wall():
		var collision = get_last_slide_collision()
		if collision:
			if collision.get_normal().x < 0 and not floor_detector_right.is_colliding():
				velocity.y = corner_correction_horizontal
			
			if collision.get_normal().x > 0 and not floor_detector_left.is_colliding():
				velocity.y = corner_correction_horizontal

func reset_correcting_ledge() -> void:
	if not is_on_wall(): is_correcting_ledge = false

func _on_on_screen_exited() -> void:
	if position.y > 270:
		is_dead = true
		emit_signal("dead")
