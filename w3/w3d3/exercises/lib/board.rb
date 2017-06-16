class Board
  attr_reader :grid, :ships
  
  def initialize(grid = Board.default_grid)
    @grid = grid
    @ships = []
  end
  
  def self.default_grid
    Array.new(10) { Array.new(10) }
  end

  def count
    grid.reduce(0) { |sum, row| sum + row.count(:s) }
  end
  
  def ship_count
    ships.length
  end

  def empty?(pos = nil)
    pos ? self[pos].nil? : count == 0
  end
  
  def full?
    grid.all? { |row| row == row.compact }
  end
  
  def won?
    count == 0
  end
  
  def populate_grid(ship_lengths)
    ship_lengths.each { |len| place_random_ship(len) unless full? }
  end
  
  def place_random_ship(length = 1)
    raise("Board full") if full?
    mark_board(random_ship(length))
  end
  
  def mark_board(ship)
    ship.pegs.each { |pos| self[pos] = :s }
    ships << ship
  end
  
  def [](pos)
    a,b = pos
    grid[a][b]
  end
  
  def []=(pos, mark)
    a,b = pos
    grid[a][b] = mark
  end
  
  def in_range?(pos)
    pos.all? { |i| (0...grid.length).include?(i) }
  end
  
  def valid_attack_pos?(pos)
    (empty?(pos) && in_range?(pos)) || self[pos] == :s
  end
  
  def valid_placement?(ship)
    return false if ship.nil?
    ship.pegs.all? { |pos| in_range?(pos) && self[pos] != :s  }
  end
  
  def update_ships
    ships.each do |ship|
      if ship.pegs.all? { |pos| self[pos] == :x }
        ship.pegs.each { |pos| self[pos] = :o }
      end
    end
    
    ships.reject! do |ship|
      ship.pegs.all? { |pos| self[pos] == :o }
    end
  end
  
  def display(hide_ships = true)
    puts "   0 1 2 3 4 5 6 7 8 9"
    
    grid.each_with_index do |row, i|
      row_string = []
      row.each do |el|
        case el
        when :x then row_string << "x"
        when :o then row_string << "o"
        when :s then hide_ships ? row_string << " " : row_string << "s"
        else row_string << " "
        end
      end
      puts "#{i}: #{row_string.join(" ")}"
    end
  end
  
  private
  
  def random_ship(length)
    ship = nil
    ship = Ship.random(length) until ship && valid_placement?(ship)
    ship
  end
  
end