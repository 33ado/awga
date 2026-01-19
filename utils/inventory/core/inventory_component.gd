extends Node
class_name InventoryComponent

@export var inventory: InventoryData

func _ready() -> void:
	if not inventory:
		inventory = InventoryData.new()

func add_item(item : ItemData, amount : int = -1):
	inventory.add_item(item, amount)

func remove_item(item : ItemData, amount : int = -1):
	inventory.remove_item(item, amount)

func move_slot(from_index : int, to_index : int):
	inventory.move_slot(from_index, to_index)

func split_stack(from_index : int, to_index : int, amount : int):
	inventory.split_stack(from_index, to_index, amount)
	
func get_slot(index : int) -> InventorySlot:
	return inventory.get_slot(index)
