require 'singleton'

module SlidingPiece

end

module SteppingPiece

end

class Piece
  attr_reader :value

  def initialize(value)
    @value = value
    @moves = []
  end

  def moves

  end

end

class Queen < Piece
  include SlidingPiece
  def initialize
    super("Q")
  end

  def move_dirs

  end
end

class Bishop < Piece
  include SlidingPiece
  def initialize
    super("B")
  end

  def move_dirs

  end
end

class Rook < Piece
  include SlidingPiece
  def initialize
    super("R")
  end

  def move_dirs

  end
end

class King < Piece
  include SteppingPiece
  def initialize
    super("K")
  end

end

class Knight < Piece
  include SteppingPiece
  def initialize
    super("N")
  end

end

class Pawn < Piece
  def initialize
    super("P")
  end
end

class NullPiece < Piece
  include Singleton
end
