require_relative 'board.rb'
require_relative 'card.rb'
require_relative 'player.rb'
require 'byebug'

#logic for game
class Game
  BOARD_SIZE = 4

  attr_reader :board, :player

  def initialize(player)
    @board = Board.new(BOARD_SIZE)
    @player = player
  end

  def play
    board.populate
    reset = true
    guess = nil
    if player.is_a? ( ComputerPlayer )
      player.board = @board
      reset = false
    end
    board.render
    until over?
      system('clear') if reset
      board.render
      if guess
        puts "guess1: #{board[guess[0]]}, guess2: #{board[guess[1]]}"
      end
      guess = make_guess
    end
    board.render
    puts "Congratulations, you win!!!"
  end

  def over?
    board.won?
  end

  def make_guess
    guess = player.get_guess
    guess.each { |pos| board[pos].flip! }
    unless board[guess[0]] == board[guess[1]]
      guess.each do |pos|
        board[pos].flip!
      end
    end
  rescue
    puts "Not a valid guess"
    retry
  ensure
    guess
  end
end

#run game
begin
  if __FILE__ == $PROGRAM_NAME
    puts "///MEMORY///"
    print "Play as a Human? (Y/N) >> "
    response = gets[0].downcase
    if response == "y"
      player = HumanPlayer.new
    elsif response == "n"
      player = ComputerPlayer.new
    else
      raise
    end
    game = Game.new(player)
    game.play
  end
rescue
  puts "Not a valid response"
  retry
end
