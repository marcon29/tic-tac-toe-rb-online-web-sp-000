WIN_COMBINATIONS = [
	[0, 1, 2]
	[3, 4, 5]
	[6, 7, 8]
	[0, 3, 6]
	[1, 4, 7]
	[2, 5, 8]
	[0, 4, 8]
	[2, 4, 6]
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

def position_empty?(board, index)
	if board[index] == " "
		true
	else
		puts "That space is already taken."
		false
	end
end

# move validation code
def valid_move?(board, index)
	if index.between?(0,8)
		position_empty?(board, index)
	else
		puts "That space is not on the board."
		false
	end
end

# updates board with player moves
def move(board, index, current_player="X")
	board[index] = current_player
end

# executes one turn
def turn(board)
	puts "Where would #{current_player(board)} like to go? (enter 1-9)"
	input = gets.strip
	index = input_to_index(input)

	if valid_move?(board, index)
		move(board, index)
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
	result = WIN_COMBINATIONS.select do |win_combo|
		win_combo.all? { |win_index| board[win_index] == "X"} ||
		win_combo.all? { |win_index| board[win_index] == "O"}
	end
	result[0]
end

# check if board is full
def full?(board)
	!(board.any? { |space| space == " " })
end

# displays message to players???
def winner(board)
	if won?(board).class == Array
		board[won?(board)[0]]
	end
end

# displays message to players???
def draw?(board)
	full?(board) == true && won?(board) == nil
end

# end game - check to play again, validates answer, restarts or closes down
def over?(board)
	if full?(board) == true
		true
	elsif won?(board).class == Array
		true
	end
end

# executes a full game loop
def play
end
