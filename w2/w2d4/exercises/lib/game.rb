require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_reader :board, :current_player, :player_one, :player_two
  
  def initialize(player_one = HumanPlayer.new, player_two = ComputerPlayer.new)
    @board = Board.new
    @player_one, @player_two = player_one, player_two
    @player_one.mark = :X
    @player_two.mark = :O
    @current_player = @player_one
  end
  
  def play_turn
    current_player.display(board)
    pos = current_player.get_move
    board.place_mark(pos, current_player.mark)
    switch_players!
  end
  
  def switch_players!
    @current_player = (current_player == player_one) ? player_two: player_one
  end
  
  def play
    play_turn until board.over?
    if board.winner
      congratulations(board.winner)
    else
      puts "CAT'S GAME"
    end
  end
  
  private
  
  def congratulations(mark)
    current_player.display(board)
    who_won = mark == player_one.mark
    puts who_won ? "#{player_one.name} wins!": "#{player_two.name} wins!"
  end
  
end

if __FILE__ == $PROGRAM_NAME
  print "Enter name: "
  name = gets.chomp
  puts
  game = Game.new(HumanPlayer.new(name), HumanPlayer.new)
  game.play
end
