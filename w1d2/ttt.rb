class Board
  attr_accessor :board
  def initialize
    @board = Array.new(3) { Array.new(3, nil) }

  end

  def get_cell(pos)
    x, y = pos
    @board[x][y]
  end

  def deep_dup
    duped_board = Board.new
    (0..2).each do |row|
      (0..2).each do |col|
        duped_board.board[row][col] = board[row][col]
      end
    end
    duped_board
  end


  def won?
    temp = []
    board.each do |row|
      temp << row
    end
    board.transpose.each do |row|
      temp << row
    end
    diagonal.each do |row|
      temp << row
    end
    temp.any? do |row|
      row.uniq.size == 1 && !row.uniq.first.nil?
    end
  end

  def moves_available
    left_over = []
    (0..2).each do |x|
      (0..2).each do |y|
        left_over << [x, y] if empty?([x, y])
      end
    end
    left_over

    # @board.any? do |row|
    #   row.any? do |cell|
    #     cell.nil?
    #   end
    # end
  end



  def diagonal
    dia1 = []
    dia2 = []
    (0..2).each do |i|
      dia1 << board[i][i]
      dia2 << board[i][2 - i]
    end
    [dia1, dia2]
  end

  def winner
    Game.current_player if won?
  end

  def empty?(pos)
    x, y = pos
    @board[x][y].nil?
  end

  def place_mark(pos, mark)
      x, y = pos if empty?(pos)
      @board[x][y] = mark
  end

  def render
    @board.each do |row|
      p row
    end
  end

end

class Game
  attr_accessor :game_board, :players

  def initialize
    @game_board = Board.new
    @players = Hash.new({})
  end

  def game_start
    puts "How many players?"
    num = gets.chomp.to_i
    marker = 0
    num.times do
      puts "What is your name?"
      name = gets.chomp
      @players[marker] = HumanPlayer.new(name, marker)
      marker += 1
    end
    @players[1] = ComputerPlayer.new if num == 1
    @current_player = @players[0]
    play
  end

  def play
    game_board.render
    p "Players #{@current_player.name} Turn."
    puts
    if @current_player.class == ComputerPlayer
      @current_player.place_mark(game_board)
    else
      p "Where would you like to move?"
      move = gets.chomp.split(',').map(&:to_i)
      @current_player.place_mark(game_board, move)
    end
    return puts "You win #{@current_player.name}." if game_board.won?
    return puts "Game is a tie" unless game_board.moves_available.size != 0
    @current_player = players[(players.key(@current_player) - 1).abs]
    play
  end
end

class Player
  attr_reader :name, :mark
  def initialize(name, mark)
    @name, @mark = name, mark
  end

  def place_mark(game_board, pos)
    game_board.place_mark(pos, mark)
  end
end

class HumanPlayer < Player
  def initialize(name, mark)
    super(name, mark)
  end
end

class ComputerPlayer < Player
  def initialize
    @name = "Computer"
    @mark = 1
  end

  def place_mark(game_board)
    pos = winning_moves(game_board)
    game_board.place_mark(pos, mark)
  end

  def winning_moves(game_board)
    test_game_board = game_board.deep_dup
    possible_moves = test_game_board.moves_available
    moves = possible_moves.select do |move|
      test_game_board.place_mark(move, mark)
      test_game_board.won?
    end
    moves.empty? ? random_move(game_board) : moves.sample
  end

  def random_move(game_board)
    game_board.moves_available.sample
  end

end

game = Game.new
game.game_start
