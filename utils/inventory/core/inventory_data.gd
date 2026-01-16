extends Resource
class_name InventoryData

@export var size : int = 20
var slots : Array[InventorySlot] = []

func _init() -> void:
	slots.resize(size)
	
	for i in range(size):
		slots[i] = InventorySlot.new()
		
	print(slots)
		
func add_item(item : ItemData, amount : int = -1) -> int:
	var remaining = amount
	
	for slot in slots:
		if remaining <= 0:
			break
		
		# Check if item in inventory
		if slot.can_stack_with(item):
			var space = item.max_stack - slot.amount
			var take = min(space, remaining)
			slot.amount += take
			remaining -= take
		# Make new stack
		elif slot.is_empty():
			slot.item = item
			
			var space = item.max_stack - slot.amount
			var take = min(space, remaining)
			slot.amount += take
			remaining -= take
			
	return remaining

func remove_item(item : ItemData, amount : int = -1):
	pass
