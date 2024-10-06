extends Node2D

@export var address = "127.0.0.1"
@export var port = 8910
var peer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.server_disconnected.connect(server_disconnected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func peer_connected(id):
	print("peer_connected ", id)


func peer_disconnected(id):
	print("peer_disconnected ", id)


func connected_to_server():
	print("Connected to server")
	# sendPlayerInformation.rpc($Buttons/LineEdit.text, multiplayer.get_unique_id(), peer)


func server_disconnected():
	print("server_disconnected")


# @rpc("any_peer")
# func sendPlayerInformation(name, id, peer):
# 	if !MultiplayerManager.Players.has(id):
# 		MultiplayerManager.Players[id] = {
# 			"name": name,
# 			"id": id,
# 			"peer": peer
# 		}

# 	elif multiplayer.is_server():
# 		for i in MultiplayerManager.Players:
# 			sendPlayerInformation(MultiplayerManager.Players[i].name, i, peer)


#let's load multiplayer scene
@rpc("any_peer", "call_local")
func start_game():
	var scene = load("res://scenes/multiplayer.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()


func _on_main_menu_pressed() -> void:
	if multiplayer.is_server():
		multiplayer.server_disconnected.emit(multiplayer.get_unique_id())
	else:
		multiplayer.peer_disconnected.emit(multiplayer.get_unique_id())
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")


#this function will be called when the player wants to host a session
func _on_host_pressed() -> void:
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 2)
	if error != OK:
		print("error creating server ", error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("waiting for players!")
	# sendPlayerInformation($Buttons/LineEdit.text, multiplayer.get_unique_id(), peer)


#this function will be called when the player wants to join a session
func _on_join_pressed() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)


#this function will be called to start the game
func _on_start_game_pressed() -> void:
	if multiplayer.is_server():
		start_game.rpc()
	else:
		print("Not a server or server not started yet")
