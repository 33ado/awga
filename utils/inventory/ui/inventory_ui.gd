extends Control
class_name InventoryUI

static var drag_origin := -1

@export var inventory_component : InventoryComponent
@export var slot_scene := preload("res://utils/inventory/ui/inventory_slot_ui.tscn")

@onready var slots_container := $Slots

func _ready() -> void:
	inventory_component.inventory_changed.connect(refresh)
	_build_slots()
	refresh()
	print_tree_pretty()

func _build_slots():
	for i in inventory_component.inventory.size:
		var slot_ui = slot_scene.instantiate()
		slot_ui.index = i
		slot_ui.set_inventory(inventory_component)
		slots_container.add_child(slot_ui)

func refresh():
	for slot_ui in slots_container.get_children():
		slot_ui.refresh()
