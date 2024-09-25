extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()

func gameOver():
	get_tree().paused = true
	self.show()

func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_to_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
