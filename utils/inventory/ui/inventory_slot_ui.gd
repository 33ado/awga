extends Panel
class_name InventorySlotUI

@export var index : int
var inventory : InventoryComponent
var inventory_ui: InventoryUI

@onready var icon := $MarginContainer/CenterContainer/Icon
@onready var amount_label := $AmountLabel

func set_inventory(inv_comp : InventoryComponent, inv_ui : InventoryUI):
	inventory = inv_comp
	inventory_ui = inv_ui
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

# Drag and drop implementation
func _get_drag_data(at_position: Vector2) -> Variant:
	# Drag preview texture
	var preview_texture = TextureRect.new()
	preview_texture.texture = icon.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(32, 32)
	
	var preview = Control.new()
	preview.add_child(preview_texture) 
	set_drag_preview(preview)
	
	return self
	
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is InventorySlotUI
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	inventory.move_slot(data.index, index)
	
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		inventory_ui.open_context_menu(index, global_position + event.position)
