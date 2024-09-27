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

# A map containting all the adjacent positions possible for a speciific position
@onready var buttonAdjacencyMap = {
	"1": [[0, 1], [1, 0], [1, 1]],
	"2": [[0, 0], [0, 2], [1, 1]],
	"3": [[0, 1], [1, 2], [1, 1]],
	"4": [[1, 1], [0, 2], [2, 2]],
	"5": [[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1], [2, 2]],
	"6": [[0, 0], [2, 0], [1, 1]],
	"7": [[1, 0], [1, 1], [2, 1]],
	"8": [[2, 0], [1, 1], [2, 2]],
	"9": [[2, 1], [1, 1], [1, 2]]
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
	

func checkForAdjacentX():
	#this function will check for adjacent x to the current position of the x
	var possibleAdjacentPositions: Array = buttonAdjacencyMap[currentButtonPressed]
	for i in (possibleAdjacentPositions.size()):
		var possiblePositionArray: Array = possibleAdjacentPositions[i]
		var x_position: int = possiblePositionArray[0]
		var y_position: int = possiblePositionArray[1]
		print(grid[x_position][y_position])
			
	pass


func _on_button_1_pressed() -> void:
	currentButtonPressed = "1"
	if grid[0][0] == "":
		turn += 1
		var x1 = x.get_child(0)
		x1.visible = true
		grid[0][0] = "X"
		checkForAdjacentX()
	elif currentTurn == "o" && grid[0][0] == "":
		turn += 1
		var o1 = o.get_child(0)
		o1.visible = true
		grid[0][0] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_2_pressed() -> void:
	currentButtonPressed = "2"
	checkForAdjacentX()
	if currentTurn == "x" && grid[0][1] == "":
		turn += 1
		var x2 = x.get_child(1)
		x2.visible = true
		grid[0][1] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[0][1] == "":
		turn += 1
		var o2 = o.get_child(1)
		o2.visible = true
		grid[0][1] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_3_pressed() -> void:
	currentButtonPressed = "3"
	checkForAdjacentX()
	if currentTurn == "x" && grid[0][2] == "":
		turn += 1
		var x3 = x.get_child(2)
		x3.visible = true
		grid[0][2] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[0][2] == "":
		turn += 1
		var o3 = o.get_child(2)
		o3.visible = true
		grid[0][2] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_4_pressed() -> void:
	currentButtonPressed = "4"
	checkForAdjacentX()
	if currentTurn == "x" && grid[1][2] == "":
		turn += 1
		var x4 = x.get_child(3)
		x4.visible = true
		grid[1][2] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[1][2] == "":
		turn += 1
		var o4 = o.get_child(3)
		o4.visible = true
		grid[1][2] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_5_pressed() -> void:
	currentButtonPressed = "5"
	checkForAdjacentX()
	if currentTurn == "x" && grid[1][1] == "":
		turn += 1
		var x5 = x.get_child(4)
		x5.visible = true
		grid[1][1] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[1][1] == "":
		turn += 1
		var o5 = o.get_child(4)
		o5.visible = true
		grid[1][1] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_6_pressed() -> void:
	currentButtonPressed = "6"
	checkForAdjacentX()
	if currentTurn == "x" && grid[1][0] == "":
		turn += 1
		var x6 = x.get_child(5)
		x6.visible = true
		grid[1][0] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[1][0] == "":
		turn += 1
		var o6 = o.get_child(5)
		o6.visible = true
		grid[1][0] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_7_pressed() -> void:
	currentButtonPressed = "7"
	checkForAdjacentX()
	if currentTurn == "x" && grid[2][0] == "":
		turn += 1
		var x7 = x.get_child(6)
		x7.visible = true
		grid[2][0] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[2][0] == "":
		turn += 1
		var o7 = o.get_child(6)
		o7.visible = true
		grid[2][0] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_8_pressed() -> void:
	currentButtonPressed = "8"
	checkForAdjacentX()
	if currentTurn == "x" && grid[2][1] == "":
		turn += 1
		var x8 = x.get_child(7)
		x8.visible = true
		grid[2][1] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[2][1] == "":
		turn += 1
		var o8 = o.get_child(7)
		o8.visible = true
		grid[2][1] = "O"
		currentTurn = "x"
	winner = checkWinner()


func _on_button_9_pressed() -> void:
	currentButtonPressed = "9"
	checkForAdjacentX()
	if currentTurn == "x" && grid[2][2] == "":
		turn += 1
		var x9 = x.get_child(8)
		x9.visible = true
		grid[2][2] = "X"
		currentTurn = "o"
	elif currentTurn == "o" && grid[2][2] == "":
		turn += 1
		var o9 = o.get_child(8)
		o9.visible = true
		grid[2][2] = "O"
		currentTurn = "x"
	winner = checkWinner()
