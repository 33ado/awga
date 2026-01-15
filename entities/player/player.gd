extends CharacterBody2D
class_name Player

const SPEED := 400
const JUMP_FORCE : float = 500.0
const ACCELERATION : float = 1.0
const DECELERATION : float = 1.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	move_and_slide()
