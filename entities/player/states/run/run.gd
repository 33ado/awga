extends State
class_name Run

@export var coyote_timer : CoyoteTimer

func physics_update(delta : float) -> void:
	parent.velocity.y += parent.gravity * delta
	
	if Input.get_axis("ui_left", "ui_right") == 0:
		transitioned.emit(self, "idle")
	
	var direction := Input.get_axis("ui_left", "ui_right")
	parent.velocity.x = lerp(parent.velocity.x, direction * parent.SPEED, parent.ACCELERATION)
	
	if not parent.is_on_floor():
		coyote_timer.start_coyote_timer()
		transitioned.emit(self, "fall")
	
func on_input(event : InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		transitioned.emit(self, "jump")
