# -> lib/tic_tac_toe.rb

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
]

# defines board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
	puts "-----------"
	puts " #{board[3]} | #{board[4]} | #{board[5]} "
	puts "-----------"
	puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# converts player move to board position
def input_to_index(user_input)
	user_input.to_i - 1
end

def position_taken?(board, location)
	if board[location] != " " && board[location] != ""
		puts "That space is already taken."
		true
	else
		false
	end
end

# move validation code
def valid_move?(board, index)
	if index.between?(0,8)
		!position_taken?(board, index)
	else
		puts "That space is not on the board."
		false
	end
end

# updates board with player moves
def move(board, index, current_player)
	board[index] = current_player
end

# executes one turn
def turn(board)
	puts "Where would #{current_player(board)} like to go? (enter 1-9)"
	input = gets.strip
	index = input_to_index(input)

	if valid_move?(board, index)
		move(board, index, current_player(board))
		display_board(board)
	else
		turn(board)
	end
end

# tracks number of turn have been taken
def turn_count(board)
	play_count = 0
	board.each do |space|
    if space == "X" || space == "O"
		play_count += 1
		end
	end
	play_count
end

#switches players
def current_player(board)
	if turn_count(board).even?
		"X"
	else
		"O"
	end
end

# checks win, returns array of winning board indices, if no win, returns empty array
def won?(board)
  win_array = WIN_COMBINATIONS.select do |win_combo|
    win_combo.all? { |win_index| board[win_index] == "X"} ||
    win_combo.all? { |win_index| board[win_index] == "O"}
  end
  win_array[0]
end

# check if board is full
def full?(board)
  !(board.any? { |space| space == " " })
end

# displays message to players???
def draw?(board)
	full?(board) && !won?(board)
end

# end game - checks if game over, displays appropriate message
def over?(board)
  won?(board) || full?(board) || draw?(board)
end

# checks which player won
def winner(board)
	if won?(board)
		board[won?(board)[0]]
  end
end

# executes a full game loop
def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  else
    current_player(board)
  end
end
