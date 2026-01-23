extends Control
class_name InventoryUI

@export var inventory_component : InventoryComponent
@export var slot_scene := preload("res://utils/inventory/ui/inventory_slot_ui.tscn")

@onready var slots_container := $Slots
@onready var context_menu := $ContextMenu

func _ready() -> void:
	inventory_component.inventory_changed.connect(refresh)
	context_menu.id_pressed.connect(_on_context_menu_id_pressed)
	_build_slots()
	refresh()

func open_context_menu(index : int, pos : Vector2):
	var slot = inventory_component.get_slot(index)
	if slot.is_empty():
		return 
		
	context_menu.clear()
	context_menu.add_item("Use", 0)
	context_menu.add_item("Split", 1)
	context_menu.add_item("Drop", 2)
	context_menu.popup(Rect2(pos, Vector2.ZERO))
	context_menu.set_meta("slot", index)

func _on_context_menu_id_pressed(id):
	var index = context_menu.get_meta("slot")

	match id:
		0: inventory_component.use_slot(index)
		1: 
			var to_slot := inventory_component.get_first_empty_slot()
			if to_slot:
				inventory_component.split_stack(index, to_slot.index, 1)
		2: inventory_component.drop_slot(index)
	
func _build_slots():
	for i in inventory_component.get_inventory_size():
		var slot_ui = slot_scene.instantiate()
		slot_ui.index = i
		slot_ui.set_inventory(inventory_component, self)
		slots_container.add_child(slot_ui)

func refresh():
	for slot_ui in slots_container.get_children():
		slot_ui.refresh()
