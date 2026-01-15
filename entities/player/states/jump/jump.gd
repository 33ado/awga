extends State
class_name Jump

# Variables for variable jump
@export var min_jump_multiplier : float = 0.5

func enter() -> void:
	parent.velocity.y = -parent.JUMP_FORCE

func physics_update(delta : float) -> void:
	parent.velocity.y += parent.gravity * delta
	
	var direction := Input.get_axis("ui_left", "ui_right")
	parent.velocity.x = lerp(parent.velocity.x, direction * parent.SPEED, parent.ACCELERATION)
	
	# Implementing variable jump
	if Input.is_action_just_released("ui_accept"):
		parent.velocity.y *= min_jump_multiplier
	
	if parent.velocity.y > 0:
		transitioned.emit(self, "fall")
