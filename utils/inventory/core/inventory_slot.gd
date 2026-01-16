extends Resource
class_name InventorySlot

@export var item : ItemData
@export var amount : int = 0

func is_empty() -> bool: 
	return not item or amount <= 0
	
func can_stack_with(other : ItemData) -> bool:
	return not is_empty() and item == other and amount < item.max_stack
	
func clear() -> void: 
	item = null 
	amount = 0
