require_relative 'piece'
require 'byebug'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(4) { Array.new(8) }
    royal_row = [Rook.new, Knight.new, Bishop.new, King.new,
                Queen.new, Bishop.new, Knight.new, Rook.new]
    pawn_row = Array.new(8) { Pawn.new }
    [pawn_row, royal_row].each do |row|
      @grid.unshift(row.dup)
      @grid.push(row.dup)
    end
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos] && !self[end_pos]
      self[end_pos] = self[start_pos]
      self[start_pos] = nil
    else
      raise "Not a valid move"
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
