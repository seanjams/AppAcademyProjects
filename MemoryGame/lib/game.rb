require_relative 'board.rb'
require_relative 'card.rb'
require_relative 'player.rb'
require 'byebug'


class Game
  BOARD_SIZE = 4

  attr_reader :board, :player

  def initialize(player)
    @board = Board.new(BOARD_SIZE)
    @player = player
  end

  def play
    board.populate
    player.board = @board if player.is_a? ( ComputerPlayer )
    until over?
      make_guess
      board.render
    end
  end

  def over?
    board.won?
  end

  def make_guess
    #debugger
    guess = player.get_guess
    guess.each { |pos| board[pos].flip! }
    print "guess1: #{board[guess[0]].value}, "
    puts "guess2: #{board[guess[1]].value}"
    unless board[guess[0]] == board[guess[1]]
      guess.each do |pos|
        board[pos].flip!
      end
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(ComputerPlayer.new)
  game.play
end
