extends Node
class_name InventoryComponent

@export var inventory: InventoryData

func _ready() -> void:
	if not inventory:
		inventory = InventoryData.new()

func add_item(item : ItemData, amount : int = -1) -> int:
	return inventory.add_item(item, amount)

func remove_item(item : ItemData, amount : int = -1):
	inventory.remove_item(item, amount)

func move_slot(from_index : int, to_index : int):
	inventory.move_slot(from_index, to_index)

func split_stack(from_index : int, to_index : int, amount : int):
	inventory.split_stack(from_index, to_index, amount)
	
func get_slot(index : int) -> InventorySlot:
	return inventory.get_slot(index)

func give_item(item : ItemData, amount : int = -1) -> int:
	return add_item(item, amount) == 0
	
func drop_slot(index : int) -> void:
	var slot = inventory.get_slot(index)
	if not slot or slot.is_empty():
		return
	
	_spawn_world_item(slot.item, slot.amount)
	slot.clear()

func transfer_to(other : InventoryComponent, from_index : int, amount : int) -> void:
	var slot = inventory.get_slot(from_index)
	if not slot or slot.is_empty():
		return
		
	var taken = min(amount, slot.amount)
	inventory.remove_item(slot.item, taken)
	var leftover = other.add_item(slot.item, taken) 
	
	if leftover > 0:
		inventory.add_item(slot.item, leftover)

func _spawn_world_item(item : ItemData, amount : int):
	print("Dropping item: ", amount, item.display_name)
	
# Function for debugging purposes
func print_slots():
	for slot in inventory.slots:
		if slot.is_empty():
			print("Empty Slot")
		else:
			print(slot.item.display_name, slot.amount)
