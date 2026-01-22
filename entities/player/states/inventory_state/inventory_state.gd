extends State
class_name InventoryState

func enter() -> void:
	parent.inventory_ui.visible = true
	
func on_input(event : InputEvent) -> void:
	if Input.is_action_just_pressed("inventory"):
		transitioned.emit(self, "idle")
	
func exit() -> void:
	parent.inventory_ui.visible = false
