require 'singleton'
require 'byebug'

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
    deltas.map { |d| [current_pos[0] + d[0], current_pos[1] + d[1]] }
  end
end

class Piece
  attr_reader :value, :current_pos, :color

  def initialize(value, board, current_pos, color)
    @value = value
    @board = board
    @current_pos = current_pos
    @color = color
  end

  def valid_move?(end_pos)
    flag1 = self.moves.include?(end_pos)
    flag2 = @board[end_pos].color != @color || @board[end_pos].nil?
    flag1 && flag2
  end

  def pos=(new_pos)
    @current_pos = new_pos
  end
end

class Queen < Piece
  include SlidingPiece
  def initialize(board, current_pos, color)
    if color == :black
      super("♛", board, current_pos, color)
    else
      super("♕", board, current_pos, color)
    end
  end

  def moves
    move_positions(@current_pos, side: true, diag: true)
  end
end

class Bishop < Piece
  include SlidingPiece
  def initialize(board, current_pos, color)
    if color == :black
      super("♝", board, current_pos, color)
    else
      super("♗", board, current_pos, color)
    end
  end

  def moves
    move_positions(@current_pos, diag: true)
  end
end

class Rook < Piece
  include SlidingPiece
  def initialize(board, current_pos, color)
    if color == :black
      super("♜", board, current_pos, color)
    else
      super("♖", board, current_pos, color)
    end
  end

  def moves
    move_positions(@current_pos, side: true)
  end
end

class King < Piece
  include SteppingPiece
  def initialize(board, current_pos, color)
    if color == :black
      super("♚", board, current_pos, color)
    else
      super("♔", board, current_pos, color)
    end
  end

  def moves
    move_positions(@current_pos, king: true)
  end
end

class Knight < Piece
  include SteppingPiece
  def initialize(board, current_pos, color)
    if color == :black
      super("♞", board, current_pos, color)
    else
      super("♘", board, current_pos, color)
    end
  end

  def moves
    move_positions(@current_pos, knight: true)
  end
end

class Pawn < Piece
  def initialize(board, current_pos, color)
    if color == :black
      super("♟", board, current_pos, color)
    else
      super("♙", board, current_pos, color)
    end
  end

  def moves
    if @color == :black
      # debugger
      move = [@current_pos[0] + 1, @current_pos[1]]
    else
      move = [@current_pos[0] - 1, @current_pos[1]]
    end
    return [move] if @board.in_bounds?(move)
    nil
  end

end

class NullPiece < Piece
  include Singleton
  def initialize
    @value = nil
  end

end
