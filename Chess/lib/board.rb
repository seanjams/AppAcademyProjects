require_relative 'piece'
require 'byebug'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate_grid
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].valid_move?(end_pos)
      self[end_pos] = self[start_pos]
      self[end_pos].pos = end_pos
      self[start_pos] = NullPiece.instance
    else
      raise "Not a valid move"
    end
  end

  def populate_grid
    color = :black
    [0,7].each do |i|
      (0..7).each do |j|
        pos = [i,j]
        case j
        when 0,7
          self[pos] = Rook.new(self, pos, color)
        when 1,6
          self[pos] = Knight.new(self, pos, color)
        when 2,5
          self[pos] = Bishop.new(self, pos, color)
        when 3
          self[pos] = King.new(self, pos, color)
        when 4
          self[pos] = Queen.new(self, pos, color)
        end
      end
      color = :white
    end

    color = :black
    [1,6].each do |i|
      (0..7).each do |j|
        self[[i,j]] = Pawn.new(self, [i,j], color)
      end
      color = :white
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
    flag1
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
