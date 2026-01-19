extends Resource
class_name ItemData

@export var id: String
@export var display_name: String
@export var icon: Texture2D
@export var max_stack : int = 64
@export var description: String = ""

func get_display_name() -> String:
	return display_name
	
func can_stack() -> bool:
	return max_stack > 1
