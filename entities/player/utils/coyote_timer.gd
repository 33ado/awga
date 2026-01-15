extends Timer
class_name CoyoteTimer

var coyote := false

func _ready() -> void:
	timeout.connect(_on_timout)
	
func start_coyote_timer() -> void:
	start()
	coyote = true
	
func _on_timout() -> void:
	coyote = false
