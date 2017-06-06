require 'singleton'

module SlidingPiece
  DELTAS = {horiz: [1,0], vert: [0,1], diag: [[1,1],[1,-1]] }

  def moves()

  end

end

module SteppingPiece

  def moves()

  end

end

class Piece
  attr_reader :value

  def initialize(value, board, current_pos)
    @value = value
    @board = board
    @pos = current_pos
  end

  def moves

  end

end

class Queen < Piece
  include SlidingPiece
  def initialize(board, current_pos)
    super("Q", board, current_pos)
  end

  def move_dirs

  end
end

class Bishop < Piece
  include SlidingPiece
  def initialize(board, current_pos)
    super("B", board, current_pos)
  end

  def move_dirs

  end
end

class Rook < Piece
  include SlidingPiece
  def initialize(board, current_pos)
    super("R", board, current_pos)
  end

  def move_dirs

  end
end

class King < Piece
  include SteppingPiece
  def initialize(board, current_pos)
    super("K", board, current_pos)
  end

end

class Knight < Piece
  include SteppingPiece
  def initialize(board, current_pos)
    super("N", board, current_pos)
  end

end

class Pawn < Piece
  def initialize(board, current_pos)
    super("P", board, current_pos)
  end
end

class NullPiece < Piece
  include Singleton
  def initialize
    @value = nil
  end

end
