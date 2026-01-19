extends CharacterBody2D
class_name Player

const SPEED := 400
const JUMP_FORCE : float = 500.0
const ACCELERATION : float = 1.0
const DECELERATION : float = 1.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var inventory: InventoryComponent = $InventoryComponent

@export var test_item: ItemData
@export var test_inventory : InventoryComponent

func _ready():
	test_inventory = InventoryComponent.new()
	test_inventory.inventory = InventoryData.new()
	# Testing functions
	inventory.add_item(test_item, 300)
	inventory.add_item(test_item, 30)
	inventory.remove_item(test_item, 70)
	inventory.split_stack(1, 10, 30)
	inventory.print_slots()
	print("-------------------")
	inventory.drop_slot(10)
	print("-------------------")
	inventory.transfer_to(test_inventory, 3, 64)
	inventory.print_slots()
	print("-------------------")
	test_inventory.print_slots()

func _physics_process(delta: float) -> void:
	move_and_slide()
