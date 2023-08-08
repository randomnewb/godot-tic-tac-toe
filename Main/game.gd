extends Control

var board: Array
var player: String
var is_winner: bool = false
var is_gameover: bool = false
var is_draw: bool = false

var unpressed = load("res://Assets/empty.png")
var player_x = load("res://Assets/x.png")
var player_o = load("res://Assets/o.png")

func initiate_board():
	board = [
		"0", "0", "0",
		"0", "0", "0",
		"0", "0", "0"
	]
	
	$Board/Row0/Button0.texture_normal = unpressed
	$Board/Row0/Button1.texture_normal = unpressed
	$Board/Row0/Button2.texture_normal = unpressed
	$Board/Row1/Button3.texture_normal = unpressed
	$Board/Row1/Button4.texture_normal = unpressed
	$Board/Row1/Button5.texture_normal = unpressed
	$Board/Row2/Button6.texture_normal = unpressed
	$Board/Row2/Button7.texture_normal = unpressed
	$Board/Row2/Button8.texture_normal = unpressed
	is_gameover = false;
	is_winner = false;
	is_draw = false;

func initiate_player():
	player = "x";

func _ready():
	$GameoverMessage.hide()
	initiate_board()
	initiate_player()

func update_player():
	if player == "x":
		player = "o"
	else:
		player = "x";

func is_row_matched() -> bool:
	var offset = 0;
	for row in range(3):
		for index in range(0 + offset, 3 + offset):
			if board[index] == player:
				is_winner = true;
			else:
				is_winner = false;
				break
		if is_winner:
			return true
		offset += 3
	return false
	
func is_col_matched() -> bool:
	var offset = 0
	for col in range(3):
		for index in range(0 + offset, 7 + offset, 3):
			if board[index] == player:
				is_winner = true
			else:
				is_winner = false
				break
		if is_winner:
			return true
		offset += 1
	return false
	
func is_diag_matched() -> bool:
	for i in range(0, 9, 4):
		if board[i] == player:
			is_winner = true
		else:
			is_winner = false
			break
	if is_winner:
		return true
	for i in range (2, 7, 2):
		if board[i] == player:
			is_winner = true
		else:
			is_winner = false
			break
	if is_winner:
		return true
	return false
	
func is_board_full() -> bool:
	if board.has("0"):
		return false
	return true
	
func check_gameover():
	if is_row_matched() or is_col_matched() or is_diag_matched():
		is_gameover = true
		add_gameover_message()
	elif is_board_full():
		is_gameover = true
		is_draw = true
		add_gameover_message()
		
func add_gameover_message():
	if is_draw:
		$GameoverMessage/Container/Label.text = "Game is draw"
	else:
		$GameoverMessage/Container/Label.text = "Player " + player + " wins!"
	$GameoverMessage.show()
	
func make_move(index: int):
	board[index] = player
	check_gameover()
	
func is_square_free(index: int) -> bool:
	if board[index] == "0":
		return true
	return false
	
func update_board(row: int, index: int):
	var path = "Board/Row" + str(row) + "/Button" + str(index)
	if player == "x":
		get_node(path).texture_normal = player_x
	elif player == "o":
		get_node(path).texture_normal = player_o
	update_player()
			
func _on_button_0_button_up():
	if is_square_free(0) and not is_gameover:
		make_move(0)
		update_board(0, 0);

func _on_button_1_button_up():
	if is_square_free(1) and not is_gameover:
		make_move(1)
		update_board(0, 1);

func _on_button_2_button_up():
	if is_square_free(2) and not is_gameover:
		make_move(2)
		update_board(0, 2);

func _on_button_3_button_up():
	if is_square_free(3) and not is_gameover:
		make_move(3)
		update_board(1, 3);

func _on_button_4_button_up():
	if is_square_free(4) and not is_gameover:
		make_move(4)
		update_board(1, 4);

func _on_button_5_button_up():
	if is_square_free(5) and not is_gameover:
		make_move(5)
		update_board(1, 5);

func _on_button_6_button_up():
	if is_square_free(6) and not is_gameover:
		make_move(6)
		update_board(2, 6);

func _on_button_7_button_up():
	if is_square_free(7) and not is_gameover:
		make_move(7)
		update_board(2, 7);

func _on_button_8_button_up():
	if is_square_free(8) and not is_gameover:
		make_move(8)
		update_board(2, 8);

func _on_button_button_up():
	$GameoverMessage.hide()
	initiate_board()
	initiate_player()

