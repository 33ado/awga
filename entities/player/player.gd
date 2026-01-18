extends CharacterBody2D
class_name Player

const SPEED := 400
const JUMP_FORCE : float = 500.0
const ACCELERATION : float = 1.0
const DECELERATION : float = 1.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var inventory: InventoryComponent = $InventoryComponent

@export var test_item: ItemData

func _ready():
	inventory.add_item(test_item, 300)
	inventory.add_item(test_item, 30)
	inventory.remove_item(test_item, 70)
	inventory.move_slot(1, 10)

func _physics_process(delta: float) -> void:
	move_and_slide()
