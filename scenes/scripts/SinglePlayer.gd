extends Node2D

var playerChoice = "X"
var computerChoice = "O"
var winner = ""
@onready var x = get_node("X")
@onready var o = get_node("O")
@onready var turn = 0;
@onready var currentTurn = "x"

# A 2-D array representation of the playing grid
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


#this function will calculate the winning move for computer
func checkComputerWinningMove():
	var winningMoves: Array = []

	#check if the winning move is in a row
	for n in 3:
		if (((grid[n][0] == grid[n][1]) && (grid[n][0] == computerChoice && grid[n][1] == computerChoice))
		|| ((grid[n][1] == grid[n][2]) && (grid[n][1] == computerChoice && grid[n][2] == computerChoice))
		|| ((grid[n][0] == grid[n][2]) && (grid[n][0] == computerChoice && grid[n][2] == computerChoice))):
			for i in 3:
				if grid[n][i] != computerChoice && grid[n][i] == "":
					winningMoves.append([n, i])

	#check if the winning move is in a column
	for n in 3:
		if (((grid[0][n] == grid[1][n]) && (grid[0][n] == computerChoice && grid[1][n] == computerChoice))
		|| ((grid[1][n] == grid[2][n]) && (grid[1][n] == computerChoice && grid[2][n] == computerChoice))
		|| ((grid[0][n] == grid[2][n]) && (grid[0][n] == computerChoice && grid[2][n] == computerChoice))):
			for i in 3:
				if grid[i][n] != computerChoice && grid[i][n] == "":
					winningMoves.append([i, n])
	
	#check if the winning move is in a diagonal
	if ((((grid[0][0] == grid[1][1]) && (grid[0][0] == computerChoice && grid[1][1] == computerChoice)))
	|| ((grid[1][1] == grid[2][2]) && (grid[1][1] == computerChoice && grid[2][2] == computerChoice))
	|| ((grid[0][0] == grid[2][2]) && (grid[0][0] == computerChoice && grid[2][2] == computerChoice))):
		if grid[0][0] == "":
			winningMoves.append([0, 0])
		if grid[1][1] == "":
			winningMoves.append([1, 1])
		if grid[2][2] == "":
			winningMoves.append([2, 2])
	
	if ((((grid[0][2] == grid[1][1]) && (grid[0][2] == computerChoice && grid[1][1] == computerChoice)))
	|| ((grid[1][1] == grid[2][0]) && (grid[1][1] == computerChoice && grid[2][0] == computerChoice))
	|| ((grid[0][2] == grid[2][0]) && (grid[0][2] == computerChoice && grid[2][0] == computerChoice))):
		if grid[0][2] == "":
			winningMoves.append([0, 2])
		if grid[1][1] == "":
			winningMoves.append([1, 1])
		if grid[2][0] == "":
			winningMoves.append([2, 0])

	return winningMoves


#this function calculates computers next winning move
func calculateComputerNextMove():
	#get player winning moves
	var playerWinningMoves: Array = checkPlayerWinningMove()

	#get computer winning moves
	var computerWinnigMoves: Array = checkComputerWinningMove()

	if computerWinnigMoves != null && !computerWinnigMoves.is_empty():
		return computerWinnigMoves
	
	if playerWinningMoves != null && !playerWinningMoves.is_empty():
		return playerWinningMoves
	
	if (playerWinningMoves == null || playerWinningMoves.is_empty()) || (computerWinnigMoves == null || computerWinnigMoves.is_empty()):
		#check if center is available
		if grid[1][1] == "":
			return [[1, 1]]
		
		#check if corner is available - start#
		if grid[0][0] == "":
			return [[0, 0]]
		if grid[0][2] == "":
			return [[0, 2]]
		if grid[2][0] == "":
			return [[2, 0]]
		if grid[2][2] == "":
			return [[2, 2]]
		#check if corner is available - end#

		#check for empty space and return the first one you find
		for i in 3:
			for j in 3:
				if grid[i][j] == "":
					return [[i, j]]
	
	#return empty array only if every other check fails
	return []


#this function will play computers next move
func playCompNextMove():
	#get next move
	var compNextMove: Array = calculateComputerNextMove()
	if compNextMove != null && !compNextMove.is_empty():
		#get button index
		var buttonIndex: int = getNextMoveButtonIndex(compNextMove)
		var moveArray = buttonMap[buttonIndex]

		#play next move
		turn += 1
		var oChild = o.get_child(buttonIndex)
		oChild.visible = true
		grid[moveArray[0]][moveArray[1]] = "O"
		currentTurn = "x"


#this function gets the next move button index for comp
func getNextMoveButtonIndex(nextMove):
	for move in nextMove:
		for i in 9:
			var buttonIndex: Array = buttonMap[i]
			if buttonIndex.hash() == move.hash():
				return i


func _on_button_1_pressed() -> void:
	if currentTurn == "x" && grid[0][0] == "":
		turn += 1
		var x1 = x.get_child(0)
		x1.visible = true
		grid[0][0] = "X"
		currentTurn = "o"
		playCompNextMove()
	
	winner = checkWinner()


func _on_button_2_pressed() -> void:
	if currentTurn == "x" && grid[0][1] == "":
		turn += 1
		var x2 = x.get_child(1)
		x2.visible = true
		grid[0][1] = "X"
		currentTurn = "o"
		playCompNextMove()
	
	winner = checkWinner()


func _on_button_3_pressed() -> void:
	if currentTurn == "x" && grid[0][2] == "":
		turn += 1
		var x3 = x.get_child(2)
		x3.visible = true
		grid[0][2] = "X"
		currentTurn = "o"
		playCompNextMove()
	
	winner = checkWinner()


func _on_button_4_pressed() -> void:
	if currentTurn == "x" && grid[1][2] == "":
		turn += 1
		var x4 = x.get_child(3)
		x4.visible = true
		grid[1][2] = "X"
		currentTurn = "o"
		playCompNextMove()
	
	winner = checkWinner()


func _on_button_5_pressed() -> void:
	if currentTurn == "x" && grid[1][1] == "":
		turn += 1
		var x5 = x.get_child(4)
		x5.visible = true
		grid[1][1] = "X"
		currentTurn = "o"
		playCompNextMove()
	
	winner = checkWinner()


func _on_button_6_pressed() -> void:
	if currentTurn == "x" && grid[1][0] == "":
		turn += 1
		var x6 = x.get_child(5)
		x6.visible = true
		grid[1][0] = "X"
		currentTurn = "o"
		playCompNextMove()
	
	winner = checkWinner()


func _on_button_7_pressed() -> void:
	if currentTurn == "x" && grid[2][0] == "":
		turn += 1
		var x7 = x.get_child(6)
		x7.visible = true
		grid[2][0] = "X"
		currentTurn = "o"
		playCompNextMove()
	
	winner = checkWinner()


func _on_button_8_pressed() -> void:
	if currentTurn == "x" && grid[2][1] == "":
		turn += 1
		var x8 = x.get_child(7)
		x8.visible = true
		grid[2][1] = "X"
		currentTurn = "o"
		playCompNextMove()
	
	winner = checkWinner()


func _on_button_9_pressed() -> void:
	if currentTurn == "x" && grid[2][2] == "":
		turn += 1
		var x9 = x.get_child(8)
		x9.visible = true
		grid[2][2] = "X"
		currentTurn = "o"
		playCompNextMove()
	
	winner = checkWinner()
