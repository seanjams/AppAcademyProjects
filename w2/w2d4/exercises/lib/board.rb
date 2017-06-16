class Board
  attr_accessor :grid
  
  def initialize(grid = Array.new(3) { Array.new(3) })
    @grid = grid
  end
  
  def place_mark(pos, mark)
    self[pos] = empty?(pos) ? mark: raise("pos already checked")
  end
  
  def winner
    diag_winner || horiz_winner || vert_winner
  end
  
  def over?
    winner || full?
  end

  def empty?(pos)
    self[pos].nil?
  end
  
  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    grid[row][col] = mark
  end
  
  
  
  private
  
  def full?
    grid.all? { |row| row == row.compact }
  end
  
  def diag_winner
    [:X,:O].each do |mark|
      return mark if (0..2).all? { |i| grid[i][i] == mark }
      return mark if (0..2).all? { |i| grid[i][2-i] == mark }
    end
    nil
  end
  
  def vert_winner
    [:X,:O].each do |mark|
      return mark if (0..2).any? do |col|
        (0..2).all? { |row| grid[row][col] == mark }
      end
    end
    nil
  end
  
  def horiz_winner
    [:X,:O].each do |mark|
      return mark if (0..2).any? do |row|
        (0..2).all? { |col| grid[row][col] == mark }
      end
    end
    nil
  end
  
end