class HumanPlayer
  attr_reader :name
  
  def initialize(name = "Player A")
     @name = name
  end
  
  def get_play
    print "#{name}, attack position (x,y) >> "
    gets.chomp.split(",").map(&:to_i)
  end
  
  def place_ships(passed_board)
    [5,4,4,3,3,3,2,2,2,2].each do |ship_length|
      ship = get_ship(ship_length)
      if passed_board.valid_placement?(ship)
        passed_board.mark_board(ship)
      else
        puts "Error, placing random ship..."
        passed_board.place_random_ship(ship_length)
      end
      passed_board.display(false)
      puts
    end
    system ('clear')
  end
  
  private
  
  def get_ship(ship_length)
    puts "#{name}, choose a starting location (x,y) for a ship of length #{ship_length}"
    print ">> "
    start_pos = gets.chomp.split(",").map(&:to_i)
    puts "...and a starting direction (r - right, d - down)"
    print ">> "
    choice = gets.downcase.chomp
    puts
    start_dir = choice == "r" ? "horz": "vert"
    Ship.new(ship_length, start_pos, start_dir)
  end
  
end



class ComputerPlayer
  attr_reader :name
  attr_accessor :board
  
  def initialize(name = "Player B", board = Board.new)
    @name = name
    @board = board
    @hits = []
    @moves = []
  end
    
  def get_play
    pos = nil
    if @hits.any? { |hit| board[hit] == :o } || @moves.empty?
      @hits = []
      @moves = []
      pos = random_pos
    else
      @moves.shuffle!
      pos = @moves.pop
    end
    
    if board[pos] == :s
      @hits << pos
      if @hits.count > 1
        grade = [last_hit[0] - sec_last_hit[0], last_hit[1] - sec_last_hit[1]]
        power_move = [last_hit[0] + grade[0], last_hit[1] + grade[1]]
        unless board.valid_attack_pos?(power_move)
          @hits.reverse!
          power_move = [last_hit[0] - grade[0], last_hit[1] - grade[1]]
        end
        @moves = [power_move] if board.valid_attack_pos?(power_move)
      else
        @moves = neighbors(pos)
      end
    end
    pos

  end

  def place_ships(passed_board)
    passed_board.populate_grid([5,4,4,3,3,3,2,2,2,2])
  end
  
  private
  
  def neighbors(pos)
    a,b = pos
    [[a-1,b],[a+1,b],[a,b-1],[a,b+1]].select { |n| board.valid_attack_pos?(n) }
  end
  
  def last_hit
    @hits[-1]
  end
  
  def sec_last_hit
    @hits[-2]
  end
  
  def random_pos
    pos = [rand(0..9),rand(0..9)]
    pos = [rand(0..9),rand(0..9)] until board.valid_attack_pos?(pos)
    pos
  end

end
