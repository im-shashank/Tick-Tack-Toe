extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.server_disconnected.connect(server_disconnected)

	self.hide()
	if !multiplayer.is_server():
		var retryLabel = get_node("Retry")
		retryLabel.visible = false

func gameOver():
	get_tree().paused = true
	self.show()

func _on_retry_pressed() -> void:
	reloadScene.rpc()


func _on_to_main_menu_pressed() -> void:
	if multiplayer.is_server():
		multiplayer.server_disconnected.emit(multiplayer.get_unique_id())
	else:
		multiplayer.peer_disconnected.emit(multiplayer.get_unique_id())


func peer_disconnected(id):
	print("Peer disconnected", id)
	multiplayer.multiplayer_peer.close()
	toMainMenu()


func server_disconnected(id):
	print("Server disconnected", id)
	toMainMenu.rpc()
	multiplayer.multiplayer_peer.close()


@rpc("any_peer", "call_local")
func reloadScene():
	self.hide()
	get_tree().paused = false
	var scene = load("res://scenes/multiplayer.tscn").instantiate()
	get_tree().root.add_child(scene)


@rpc("any_peer", "call_local")
func toMainMenu():
	self.hide()
	get_tree().paused = false
	var scene = load("res://scenes/start_menu.tscn").instantiate()
	get_tree().root.add_child(scene)