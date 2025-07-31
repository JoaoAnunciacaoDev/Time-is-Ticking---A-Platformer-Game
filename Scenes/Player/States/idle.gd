extends State
class_name IdleState

@onready var state_machine : Node = get_parent()

func enter() -> void:
	player.anim.play("idle")
	player.reset_jump_count()
	player.move(0)

func handle_input(event : InputEvent) -> State:
	if event.is_action_pressed("jump"):
		player.reset_jump_buffer()
		return state_machine.get_node("jump")
	return null

func physics_update(_delta: float) -> State:
	var input_axis : float = Input.get_axis("left", "right")
	player.flip_sprite(input_axis)
	
	if player.is_jump_buffering():
		player.reset_jump_buffer()
		return state_machine.get_node("jump")
	
	if input_axis != 0 and player.is_on_floor():
		return state_machine.get_node("walk")
	
	if player.velocity.y > 0:
		return state_machine.get_node("fall")
	
	return null

func exit() -> void:
	pass
