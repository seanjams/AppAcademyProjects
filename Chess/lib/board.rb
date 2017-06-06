require_relative 'piece'
require 'byebug'

class Board
  attr_reader :grid


  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate_grid
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].value && self[end_pos].value.nil?
      self[end_pos] = self[start_pos]
      self[start_pos] = NullPiece.instance
    else
      raise "Not a valid move"
    end
  end

  def populate_grid
    [0,7].each do |i|
      (0..7).each do |j|
        pos = [i,j]
        case j
        when 0,7
          self[pos] = Rook.new(self, pos)
        when 1,6
          self[pos] = Knight.new(self, pos)
        when 2,5
          self[pos] = Bishop.new(self, pos)
        when 3
          self[pos] = King.new(self, pos)
        when 4
          self[pos] = Queen.new(self, pos)
        end
      end
    end

    [1,6].each do |i|
      (0..7).each do |j|
        self[[i,j]] = Pawn.new(self, [i,j])
      end
    end

    (2..5).each do |i|
      (0..7).each do |j|
        self[[i,j]] = NullPiece.instance
      end
    end

  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x,y = pos
    @grid[x][y] = piece
  end

  def valid_move?(start_pos, end_pos)
    true
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0,7) }
  end

end

# board = Board.new
# pos = [0,0]
# puts board[pos]
# board.move_piece(pos, [2,2])
# puts board[[2,2]]
# puts board.grid
