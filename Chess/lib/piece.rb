require 'singleton'

DELTAS = {side: [[1,0], [0,1], [-1,0], [0,-1]],
          diag: [[1,1], [1,-1], [-1,-1], [-1, 1]],
          knight: [[2,1], [1,2], [-2,1], [-1,2],
                  [2,-1], [1,-2], [-2,-1], [-1,-2]]}

module SlidingPiece
  def move_positions(current_pos, opts = {})
    defaults = { side: false, diag: false }
    opts = defaults.merge(opts)
    result = []
    opts.select{|k,v| v}.each do |dir, _|
      DELTAS[dir].each do |d|
        pos = sum(current_pos, d)
        while pos.all? { |x| x.between?(0,7) }
          result << pos
          pos = sum(pos, d)
        end
      end
    end
    result
  end

  def sum(pos, d)
    [pos[0] + d[0], pos[1] + d[1]]
  end
end

module SteppingPiece
  def move_positions(current_pos, opts = {})
    defaults = { king: false, knight: false }
    opts = defaults.merge(opts)
    if opts[:knight]
      neighbors(current_pos, DELTAS[:knight]).select do |neighbor|
        neighbor.all? { |x| x.between?(0,7) }
      end
    elsif opts[:king]
      potentials = neighbors(current_pos, DELTAS[:side] + DELTAS[:diag])
      potentials.select do |neighbor|
        neighbor.all? { |x| x.between?(0,7) }
      end
    end
  end

  def neighbors(current_pos, deltas)
    result = []
    deltas.each do |d|
      result << [current_pos[0] + d[0], current_pos[1] + d[1]]
    end
    result
  end
end

class Piece
  attr_reader :value, :current_pos

  def initialize(value, board, current_pos)
    @value = value
    @board = board
    @current_pos = current_pos
  end

end

class Queen < Piece
  include SlidingPiece
  def initialize(board, current_pos)
    super("Q", board, current_pos)
  end

  def moves
    move_positions(@current_pos, side: true, diag: true)
  end
end

class Bishop < Piece
  include SlidingPiece
  def initialize(board, current_pos)
    super("B", board, current_pos)
  end

  def moves
    move_positions(@current_pos, diag: true)
  end
end

class Rook < Piece
  include SlidingPiece
  def initialize(board, current_pos)
    super("R", board, current_pos)
  end

  def moves
    move_positions(@current_pos, side: true)
  end
end

class King < Piece
  include SteppingPiece
  def initialize(board, current_pos)
    super("K", board, current_pos)
  end

  def moves
    move_positions(@current_pos, king: true)
  end
end

class Knight < Piece
  include SteppingPiece
  def initialize(board, current_pos)
    super("N", board, current_pos)
  end

  def moves
    move_positions(@current_pos, knight: true)
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
