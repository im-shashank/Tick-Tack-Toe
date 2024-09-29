extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/co_op.tscn")


func _on_end_pressed() -> void:
	get_tree().quit()


func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/single_player.tscn")


func _on_multiplayer_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/multiplayer_host_or_join.tscn")
