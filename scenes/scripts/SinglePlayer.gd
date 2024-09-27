extends Node2D

var playerChoice = "X"
var winner = ""
@onready var x = get_node("X")
@onready var o = get_node("O")
@onready var turn = 0;
@onready var currentTurn = "x"
@onready var currentButtonPressed = ""

# A 2-D array representation of the playing grid
@onready var grid = [
	["", "", ""],
	["", "", ""],
	["", "", ""]
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if winner != null && winner != "":
		get_node("GameOverLayer/Label").text = "Winner is " + winner
		get_node("GameOverLayer").gameOver()
	if turn >= 9 && winner == null:
		get_node("GameOverLayer/Label").text = "The game is a draw"
		get_node("GameOverLayer").gameOver()
	pass

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


#this method will check for the next move that player requires to win the game
func checkPlayerWinningMove():
	var winningMoves: Array = []
	#check if the winning move is in a row
	var xRowCount: int = 0
	for n in 3:
		if (((grid[n][0] == grid[n][1]) && (grid[n][0] == playerChoice && grid[n][1] == playerChoice))
		|| ((grid[n][1] == grid[n][2]) && (grid[n][1] == playerChoice && grid[n][2] == playerChoice))
		|| ((grid[n][0] == grid[n][2]) && (grid[n][0] == playerChoice && grid[n][2] == playerChoice))):
			for i in 3:
				if grid[n][i] != playerChoice && grid[n][i] == "":
					winningMoves.append([n, i])

	#check if the winning move is in a column
	for n in 3:
		if (((grid[0][n] == grid[1][n]) && (grid[0][n] == playerChoice && grid[1][n] == playerChoice))
		|| ((grid[1][n] == grid[2][n]) && (grid[1][n] == playerChoice && grid[2][n] == playerChoice))
		|| ((grid[0][n] == grid[2][n]) && (grid[0][n] == playerChoice && grid[2][n] == playerChoice))):
			for i in 3:
				if grid[i][n] != playerChoice && grid[i][n] == "":
					winningMoves.append([i, n])
	
	#TODO: fix this part of the logic
	#check if the winning move is in a diagonal
	if ((((grid[0][0] == grid[1][1]) && (grid[0][0] == playerChoice && grid[1][1] == playerChoice)))
	|| ((grid[1][1] == grid[2][2]) && (grid[1][1] == playerChoice && grid[2][2] == playerChoice))
	|| ((grid[0][0] == grid[2][2]) && (grid[0][0] == playerChoice && grid[2][2] == playerChoice))):
		if grid[0][0] == "":
			winningMoves.append([0, 0])
		if grid[1][1] == "":
			winningMoves.append([1, 1])
		if grid[2][2] == "":
			winningMoves.append([2, 2])
	
	if ((((grid[0][2] == grid[1][1]) && (grid[0][2] == playerChoice && grid[1][1] == playerChoice)))
	|| ((grid[1][1] == grid[2][0]) && (grid[1][1] == playerChoice && grid[2][0] == playerChoice))
	|| ((grid[0][2] == grid[2][0]) && (grid[0][2] == playerChoice && grid[2][0] == playerChoice))):
		if grid[0][2] == "":
			winningMoves.append([0, 2])
		if grid[1][1] == "":
			winningMoves.append([1, 1])
		if grid[2][0] == "":
			winningMoves.append([2, 0])

	return winningMoves


func _on_button_1_pressed() -> void:
	currentButtonPressed = "1"
	if currentTurn == "x" && grid[0][0] == "":
		turn += 1
		var x1 = x.get_child(0)
		x1.visible = true
		grid[0][0] = "X"
		currentTurn = "o"
		var winningMove = checkPlayerWinningMove()
		print(winningMove)
	elif currentTurn == "o" && grid[0][0] == "":
		turn += 1
		var o1 = o.get_child(0)
		o1.visible = true
		grid[0][0] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_2_pressed() -> void:
	currentButtonPressed = "2"
	if currentTurn == "x" && grid[0][1] == "":
		turn += 1
		var x2 = x.get_child(1)
		x2.visible = true
		grid[0][1] = "X"
		currentTurn = "o"
		var winningMove = checkPlayerWinningMove()
		print(winningMove)
	elif currentTurn == "o" && grid[0][1] == "":
		turn += 1
		var o2 = o.get_child(1)
		o2.visible = true
		grid[0][1] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_3_pressed() -> void:
	currentButtonPressed = "3"
	if currentTurn == "x" && grid[0][2] == "":
		turn += 1
		var x3 = x.get_child(2)
		x3.visible = true
		grid[0][2] = "X"
		currentTurn = "o"
		var winningMove = checkPlayerWinningMove()
		print(winningMove)
	elif currentTurn == "o" && grid[0][2] == "":
		turn += 1
		var o3 = o.get_child(2)
		o3.visible = true
		grid[0][2] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_4_pressed() -> void:
	currentButtonPressed = "4"
	if currentTurn == "x" && grid[1][2] == "":
		turn += 1
		var x4 = x.get_child(3)
		x4.visible = true
		grid[1][2] = "X"
		currentTurn = "o"
		var winningMove = checkPlayerWinningMove()
		print(winningMove)
	elif currentTurn == "o" && grid[1][2] == "":
		turn += 1
		var o4 = o.get_child(3)
		o4.visible = true
		grid[1][2] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_5_pressed() -> void:
	currentButtonPressed = "5"
	if currentTurn == "x" && grid[1][1] == "":
		turn += 1
		var x5 = x.get_child(4)
		x5.visible = true
		grid[1][1] = "X"
		currentTurn = "o"
		var winningMove = checkPlayerWinningMove()
		print(winningMove)
	elif currentTurn == "o" && grid[1][1] == "":
		turn += 1
		var o5 = o.get_child(4)
		o5.visible = true
		grid[1][1] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_6_pressed() -> void:
	currentButtonPressed = "6"
	if currentTurn == "x" && grid[1][0] == "":
		turn += 1
		var x6 = x.get_child(5)
		x6.visible = true
		grid[1][0] = "X"
		currentTurn = "o"
		var winningMove = checkPlayerWinningMove()
		print(winningMove)
	elif currentTurn == "o" && grid[1][0] == "":
		turn += 1
		var o6 = o.get_child(5)
		o6.visible = true
		grid[1][0] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_7_pressed() -> void:
	currentButtonPressed = "7"
	if currentTurn == "x" && grid[2][0] == "":
		turn += 1
		var x7 = x.get_child(6)
		x7.visible = true
		grid[2][0] = "X"
		currentTurn = "o"
		var winningMove = checkPlayerWinningMove()
		print(winningMove)
	elif currentTurn == "o" && grid[2][0] == "":
		turn += 1
		var o7 = o.get_child(6)
		o7.visible = true
		grid[2][0] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_8_pressed() -> void:
	currentButtonPressed = "8"
	if currentTurn == "x" && grid[2][1] == "":
		turn += 1
		var x8 = x.get_child(7)
		x8.visible = true
		grid[2][1] = "X"
		currentTurn = "o"
		var winningMove = checkPlayerWinningMove()
		print(winningMove)
	elif currentTurn == "o" && grid[2][1] == "":
		turn += 1
		var o8 = o.get_child(7)
		o8.visible = true
		grid[2][1] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_9_pressed() -> void:
	currentButtonPressed = "9"
	if currentTurn == "x" && grid[2][2] == "":
		turn += 1
		var x9 = x.get_child(8)
		x9.visible = true
		grid[2][2] = "X"
		currentTurn = "o"
		var winningMove = checkPlayerWinningMove()
		print(winningMove)
	elif currentTurn == "o" && grid[2][2] == "":
		turn += 1
		var o9 = o.get_child(8)
		o9.visible = true
		grid[2][2] = "O"
		currentTurn = "x"
	winner = checkWinner()
