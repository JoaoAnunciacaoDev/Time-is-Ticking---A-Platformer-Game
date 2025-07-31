extends State
class_name FallState

@onready var state_machine : Node = get_parent()

func enter() -> void:
	pass

func handle_input(event : InputEvent) -> State:
	if event.is_action_pressed("jump"):
		player.set_jump_buffer()
		if not player.coyote_timer.is_stopped():
			return state_machine.get_node("jump")
	return null

func physics_update(_delta: float) -> State:
	var input_axis : float = Input.get_axis("left", "right")
	player.move(input_axis)
	player.flip_sprite(input_axis)
	
	if player.is_on_floor():
		player.reset_jump_count()
		player.play_squash_n_stretch()
		if input_axis == 0:
			return state_machine.get_node("idle")
		else:
			return state_machine.get_node("walk")
	
	return null

func exit() -> void:
	pass
