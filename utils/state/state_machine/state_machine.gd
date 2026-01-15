extends Node

@export var parent : Node
@export var initial_state : State
var current_state : State
var states : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(_on_state_change)
			child.parent = parent
			
	current_state = initial_state

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)
	
func _process(delta: float) -> void:
	current_state.update(delta)
	
func _input(event: InputEvent) -> void:
	current_state.on_input(event)
	
func _on_state_change(state : State, new_state_name):
	if state != current_state:
		return
	
	var new_state = states[new_state_name.to_lower()]
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
