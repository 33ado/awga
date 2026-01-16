extends Node
class_name InventoryComponent

@export var inventory: InventoryData

func _ready() -> void:
	if not inventory:
		inventory = InventoryData.new()

func add_item(item : ItemData, amount : int = -1):
	inventory.add_item(item, amount)
