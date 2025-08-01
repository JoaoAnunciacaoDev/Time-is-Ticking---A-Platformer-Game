extends Node
class_name StateMachine

@export var initial_state : State

var previous_state : State
var current_state : State
var states : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.player = get_parent()
	
	if initial_state:
		current_state = initial_state
		current_state.enter()

func _on_input(event: InputEvent) -> void:
	var new_state = current_state.handle_input(event)
	if new_state: transition_to(new_state)

func _process(delta: float) -> void:
	var new_state = current_state.update(delta)
	if new_state: transition_to(new_state)

func _physics_process(delta: float) -> void:
	var new_state = current_state.physics_update(delta)
	if new_state: transition_to(new_state)

func transition_to(new_state : State) -> void:
	if current_state: current_state.exit()
	previous_state = current_state
	current_state = new_state
	current_state.enter()
