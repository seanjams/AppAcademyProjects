require_relative 'piece'
require 'byebug'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    2.times do |i|
      @grid[i] = Array.new(8) { Piece.new("A") }
      @grid[7-i] = Array.new(8) { Piece.new("A") }
    end
  end

  def move_piece(start_pos, end_pos)
    unless self[start_pos].nil? || !valid_move?(start_pos, end_pos)
      self[end_pos] = self[start_pos]
      self[start_pos] = nil
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
