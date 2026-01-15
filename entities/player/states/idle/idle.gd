extends State
class_name Idle

@export var coyote_timer : CoyoteTimer

func enter() -> void:
	parent.velocity.x = lerp(parent.velocity.x, 0.0, parent.DECELERATION)
	
func physics_update(delta : float) -> void:
	parent.velocity.y += parent.gravity * delta
	
	if not parent.is_on_floor():
		coyote_timer.start_coyote_timer()
		transitioned.emit(self, "fall")
	
func on_input(event : InputEvent) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		transitioned.emit(self, "run")
		return
		
	if Input.is_action_just_pressed("ui_accept"):
		transitioned.emit(self, "jump")
		return
	
