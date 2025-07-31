extends State
class_name JumpState

@onready var state_machine : Node = get_parent()

func enter() -> void:
	if player.can_jump():
		player.jump()
		player.coyote_timer.stop()
	else:
		state_machine.transition_to(state_machine.get_node("fall"))
		return

func handle_input(event : InputEvent) -> State:
	if Input.is_action_just_released("jump"):
		player.cut_velocity()
	
	return null

func physics_update(_delta: float) -> State:
	var input_axis : float = Input.get_axis("left", "right")
	player.move(input_axis)
	player.flip_sprite(input_axis)
	
	if player.velocity.y > 0:
		return state_machine.get_node("fall")
	
	return null

func exit() -> void:
	pass
