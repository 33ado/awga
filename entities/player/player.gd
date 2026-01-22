extends CharacterBody2D
class_name Player

const SPEED := 400
const JUMP_FORCE : float = 500.0
const ACCELERATION : float = 1.0
const DECELERATION : float = 1.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var inventory: InventoryComponent

@export var test_item: ItemData

func _ready():
	inventory.add_item(test_item, 100)

func _physics_process(delta: float) -> void:
	move_and_slide()
