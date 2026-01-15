extends State
class_name Fall

@export var coyote_timer : CoyoteTimer

@export var jump_buffer_time : float = 0.1
var jump_buffer_timer : float

func physics_update(delta : float) -> void:
	jump_buffer_timer -= delta
	parent.velocity.y += parent.gravity * delta
	
	var direction := Input.get_axis("ui_left", "ui_right")
	parent.velocity.x = lerp(parent.velocity.x, direction * parent.SPEED, parent.ACCELERATION)
	
	if parent.is_on_floor():
		if jump_buffer_timer > 0.0:
			transitioned.emit(self, "jump")
			return
		if direction != 0:
			transitioned.emit(self, "run")
			return
		transitioned.emit(self, "idle")
	
func on_input(event : InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		# Implementation of coyote timer
		if coyote_timer.coyote:
			transitioned.emit(self, "jump")
			return
		
		jump_buffer_timer = jump_buffer_time
	
