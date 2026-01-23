extends Resource
class_name InventoryData

@export var size : int = 20
var slots : Array[InventorySlot] = []

func _init() -> void:
	slots.resize(size)
	
	for i in range(size):
		slots[i] = InventorySlot.new(i)
		
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

func remove_item(item : ItemData, amount : int = -1) -> void:
	var remaining = amount
	
	for slot in slots:
		if remaining <= 0:
			break
			
		# Check if item exists
		if slot.item == item:
			var take = min(slot.amount, remaining)
			slot.amount -= take
			remaining -= take
			if slot.amount <= 0:
				slot.clear()
				
func move_slot(from_index : int, to_index : int):
	if from_index == to_index:
		return
	
	var from_slot = slots[from_index]
	var to_slot = slots[to_index]
	
	# Check stackable and if not swap
	if from_slot.can_stack_with(to_slot.item) and to_slot.can_stack_with(from_slot.item):
		var space = to_slot.item.max_stack - to_slot.amount
		var moved = min(space, from_slot.amount)
		to_slot.amount += moved
		from_slot.amount -= moved
		if from_slot.amount <= 0:
			from_slot.clear()
	else:
		var temp_item = to_slot.item
		var temp_amount = to_slot.amount
		to_slot.item = from_slot.item
		to_slot.amount = from_slot.amount
		from_slot.item = temp_item
		from_slot.amount = temp_amount
		
func split_stack(from_index : int, to_index : int, amount : int) -> void:
	if from_index == to_index:
		return
	
	var from_slot = slots[from_index]
	var to_slot = slots[to_index]
	
	# Only letting split to empty slots
	if from_slot.is_empty() or not to_slot.is_empty():
		return
	
	var moved = min(amount, from_slot.amount)
	to_slot.item = from_slot.item
	to_slot.amount = moved
	from_slot.amount -= moved
	if from_slot.amount <= 0:
		from_slot.clear()
	
func get_slot(index : int) -> InventorySlot:
	if index >= size:
		return null
	
	return slots[index]

func get_first_empty_slot() -> InventorySlot:
	for slot in slots:
		if slot.is_empty():
			return slot
	
	return null
