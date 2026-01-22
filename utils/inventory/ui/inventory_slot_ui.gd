extends Panel
class_name InventorySlotUI

@export var index : int
var inventory : InventoryComponent

@onready var icon := $MarginContainer/CenterContainer/Icon
@onready var amount_label := $AmountLabel

func set_inventory(inv : InventoryComponent):
	inventory = inv
	refresh()

func refresh():
	if not is_node_ready():
		return
	
	var slot = inventory.get_slot(index)
	if slot.is_empty():
		icon.texture = null
		amount_label.text = ""
	else:
		icon.texture = slot.item.icon
		amount_label.text = str(slot.amount) if slot.amount > 1 else ""
	
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			inventory.move_slot(index, InventoryUI.drag_origin)
			InventoryUI.drag_origin = index
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			inventory.split_stack(index, InventoryUI.drag_origin, 1)
