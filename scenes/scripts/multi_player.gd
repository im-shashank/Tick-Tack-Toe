extends Node2D

var playerChoice = "X"
var winner = ""
@onready var x = get_node("X")
@onready var o = get_node("O")
@onready var turn = 0;
@onready var currentTurn = "x"

@onready var peer: SceneMultiplayer = get_tree().get_multiplayer()

@onready var grid = [
	["", "", ""],
	["", "", ""],
	["", "", ""]
]


@onready var buttonMap = {
	0: [0, 0],
	1: [0, 1],
	2: [0, 2],
	3: [1, 2],
	4: [1, 1],
	5: [1, 0],
	6: [2, 0],
	7: [2, 1],
	8: [2, 2]
}

signal foundWinner
signal matchDraw

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.server_disconnected.connect(server_disconnected)
	peer.peer_packet.connect(receiveDataFromPeer)

	$".".foundWinner.connect(display_gamer_over_overlay)
	$".".matchDraw.connect(match_draw)


func peer_disconnected(id):
	print("Peer disconnected: ", id)
	multiplayer.multiplayer_peer.close()
	returnToMainMenu()


func server_disconnected(id):
	print("Server diconnected: ", id)
	returnToMainMenu.rpc()
	multiplayer.multiplayer_peer.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	makeChoiceVisible()


func displayGameOverScreen():
	if winner != null && winner != "":
		get_node("GameOverLayer/Label").text = "Winner is " + winner
		get_node("GameOverLayer").gameOver()
		# foundWinner.emit()
	if turn >= 9 && winner == null:
		get_node("GameOverLayer/Label").text = "The game is a draw"
		get_node("GameOverLayer").gameOver()
		# matchDraw.emit()


func display_gamer_over_overlay():
	get_node("GameOverLayer/Label").text = "Winner is " + winner
	get_node("GameOverLayer").gameOver()


func match_draw():
	get_node("GameOverLayer/Label").text = "The game is a draw"
	get_node("GameOverLayer").gameOver()


func makeChoiceVisible():
	for i in buttonMap:
		var index = buttonMap[i]
		if grid[index[0]][index[1]] == "X":
			var x = x.get_child(i)
			if !x.visible:
				x.visible = true
		if grid[index[0]][index[1]] == "O":
			var o = o.get_child(i)
			if !o.visible:
				o.visible = true
				
@rpc("any_peer")
func checkWinner():
	#algorithm that will check who is the winner
	#check row
	for n in 3:
		if grid[n][0] == grid[n][1] && grid[n][1] == grid[n][2] && grid[n][0] == grid[n][2]:
			return grid[n][0]
	
	#check column
	for n in 3:
		if grid[0][n] == grid[1][n] && grid[1][n] == grid[2][n] && grid[0][n] == grid[2][n]:
			return grid[0][n]
	
	#check diagonal
	if grid[0][0] == grid[1][1] && grid[1][1] == grid[2][2] && grid[0][0] == grid[2][2]:
		return grid[0][0]
	elif grid[0][2] == grid[1][1] && grid[1][1] == grid[2][0] && grid[0][2] == grid[2][0]:
		return grid[0][2]
	

#send data to peers
@rpc("any_peer")
func sendDataToPeers():
	var data = {
		"grid": grid,
		"currentTurn": currentTurn,
		"turn": turn,
		"winner": winner
	}
	var json_string = JSON.stringify(data)
	var bytes = json_string.to_utf8_buffer()
	peer.send_bytes(bytes)


#receive data from peers
@rpc("any_peer")
func receiveDataFromPeer(id: int, packet: PackedByteArray):
	var data = JSON.parse_string(packet.get_string_from_utf8())
	grid = data["grid"]
	currentTurn = data["currentTurn"]
	turn = data["turn"]
	winner = data["winner"]
	print("winner is ", winner)
	displayGameOverScreen()


func _on_button_1_pressed() -> void:
	if currentTurn == "x" && grid[0][0] == "" && peer.is_server():
		turn += 1
		var x1 = x.get_child(0)
		x1.visible = true
		grid[0][0] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[0][0] == "" && !peer.is_server():
		turn += 1
		var o1 = o.get_child(0)
		o1.visible = true
		grid[0][0] = "O"
		currentTurn = "x"
	winner = checkWinner()
	sendDataToPeers()
	displayGameOverScreen()


func _on_button_2_pressed() -> void:
	if currentTurn == "x" && grid[0][1] == "" && peer.is_server():
		turn += 1
		var x2 = x.get_child(1)
		x2.visible = true
		grid[0][1] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[0][1] == "" && !peer.is_server():
		turn += 1
		var o2 = o.get_child(1)
		o2.visible = true
		grid[0][1] = "O"
		currentTurn = "x"
	winner = checkWinner()
	sendDataToPeers()
	displayGameOverScreen()


func _on_button_3_pressed() -> void:
	if currentTurn == "x" && grid[0][2] == "" && peer.is_server():
		turn += 1
		var x3 = x.get_child(2)
		x3.visible = true
		grid[0][2] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[0][2] == "" && !peer.is_server():
		turn += 1
		var o3 = o.get_child(2)
		o3.visible = true
		grid[0][2] = "O"
		currentTurn = "x"
	winner = checkWinner()
	sendDataToPeers()
	displayGameOverScreen()


func _on_button_4_pressed() -> void:
	if currentTurn == "x" && grid[1][2] == "" && peer.is_server():
		turn += 1
		var x4 = x.get_child(3)
		x4.visible = true
		grid[1][2] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[1][2] == "" && !peer.is_server():
		turn += 1
		var o4 = o.get_child(3)
		o4.visible = true
		grid[1][2] = "O"
		currentTurn = "x"
	winner = checkWinner()
	sendDataToPeers()
	displayGameOverScreen()


func _on_button_5_pressed() -> void:
	if currentTurn == "x" && grid[1][1] == "" && peer.is_server():
		turn += 1
		var x5 = x.get_child(4)
		x5.visible = true
		grid[1][1] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[1][1] == "" && !peer.is_server():
		turn += 1
		var o5 = o.get_child(4)
		o5.visible = true
		grid[1][1] = "O"
		currentTurn = "x"
	winner = checkWinner()
	sendDataToPeers()
	displayGameOverScreen()


func _on_button_6_pressed() -> void:
	if currentTurn == "x" && grid[1][0] == "" && peer.is_server():
		turn += 1
		var x6 = x.get_child(5)
		x6.visible = true
		grid[1][0] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[1][0] == "" && !peer.is_server():
		turn += 1
		var o6 = o.get_child(5)
		o6.visible = true
		grid[1][0] = "O"
		currentTurn = "x"
	winner = checkWinner()
	sendDataToPeers()
	displayGameOverScreen()


func _on_button_7_pressed() -> void:
	if currentTurn == "x" && grid[2][0] == "" && peer.is_server():
		turn += 1
		var x7 = x.get_child(6)
		x7.visible = true
		grid[2][0] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[2][0] == "" && !peer.is_server():
		turn += 1
		var o7 = o.get_child(6)
		o7.visible = true
		grid[2][0] = "O"
		currentTurn = "x"
	winner = checkWinner()
	sendDataToPeers()
	displayGameOverScreen()


func _on_button_8_pressed() -> void:
	if currentTurn == "x" && grid[2][1] == "" && peer.is_server():
		turn += 1
		var x8 = x.get_child(7)
		x8.visible = true
		grid[2][1] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[2][1] == "" && !peer.is_server():
		turn += 1
		var o8 = o.get_child(7)
		o8.visible = true
		grid[2][1] = "O"
		currentTurn = "x"
	winner = checkWinner()
	sendDataToPeers()
	displayGameOverScreen()


func _on_button_9_pressed() -> void:
	if currentTurn == "x" && grid[2][2] == "" && peer.is_server():
		turn += 1
		var x9 = x.get_child(8)
		x9.visible = true
		grid[2][2] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[2][2] == "" && !peer.is_server():
		turn += 1
		var o9 = o.get_child(8)
		o9.visible = true
		grid[2][2] = "O"
		currentTurn = "x"
	winner = checkWinner()
	sendDataToPeers()
	displayGameOverScreen()


func _on_leave_pressed() -> void:
	if multiplayer.is_server():
		multiplayer.server_disconnected.emit(multiplayer.get_unique_id())
	else:
		multiplayer.peer_disconnected.emit(multiplayer.get_unique_id())


@rpc("any_peer", "call_local")
func returnToMainMenu():
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
