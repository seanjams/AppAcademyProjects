require_relative 'board'
require_relative 'player'
require_relative 'ship'

class BattleshipGame
  attr_accessor :board, :player
  
  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @board_one = Board.new
    @board_two = Board.new
    @player = @player_one
    @board = @board_one
  end
  
  def self.single_player(player)
    BattleshipGame.new(player, nil)
  end
  
  def self.multi_player(player_one, player_two)
    BattleshipGame.new(player_one, player_two)
  end
  
  def attack(pos)
    board[pos] = :x if board.valid_attack_pos?(pos)
    board.update_ships
  end
  
  def count
    board.count
  end
  
  def game_over?
    return @board_one.won? || @board_two.won? if @player_two
    board.won?
  end
  
  def play_turn
    pos = player.get_play
    attack(pos)
    player.board = board if player.is_a?( ComputerPlayer )
  end
  
  def play
    if @player_two.nil?
      puts "\n///BATTLESHIP(single player)///"
      board.populate_grid([5,4,4,3,3,3,2,2,2,2])
    else
      puts "\n///BATTLESHIP(multi player)///"
      puts "Setup phase: "
      puts
      board.display
      puts
      setup_phase
    end
    puts "Attack phase: "
    until game_over?
      display_status if player.is_a?( HumanPlayer )
      play_turn
      display_status if player.is_a?( ComputerPlayer )
      switch_players! if @player_two
    end 
    switch_players! if @player_two
    puts "#{player.name} wins!"
  end
  
  private
  
  def switch_players!
    if player == @player_one
      @player = @player_two
      @board = @board_two
    else
      @player = @player_one
      @board = @board_one
    end
  end
  
  def setup_phase
   @player_one.place_ships(@board_two)
   @player_two.place_ships(@board_one)
  end
  
  def display_status
    puts "\n#{player.name}: "
    board.display(player.is_a?( HumanPlayer ))
    puts "Remaining Targets: #{count}"
    puts "Remaining Ships:   #{board.ship_count}"
    puts
  end
  
end



if __FILE__ == $PROGRAM_NAME
  print "Multiplayer? (y/n): "
  choice_one = gets.downcase.chomp
  if choice_one == "y"
    print "Play against computer? (y/n): "
    choice_two = gets.downcase.chomp
  end
  
  print "Player A choose name: "
  name_one = gets.chomp
  if choice_one == "y" && choice_two != "y"
    print "Player B choose name: "
    name_two = gets.chomp
  end
  
  player_one = HumanPlayer.new(name_one)
  player_two = choice_two == "y" ? ComputerPlayer.new: HumanPlayer.new(name_two)
  
  if choice_one == "y"
    game = BattleshipGame.multi_player(player_one, player_two)
  else
    game = BattleshipGame.single_player(player_one)
  end
 
  game.play
end

