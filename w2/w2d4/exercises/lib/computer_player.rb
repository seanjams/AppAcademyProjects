require_relative 'human_player'

class ComputerPlayer < HumanPlayer
  attr_reader :board
  
  def initialize(name = "Computer")
    super(name)
    @board = Board.new
  end
  
  def get_move
    puts "#{name}'s move:"
    puts
    winning_move || random_move
  end
  
  def display(passed_board)
    @board = passed_board
    super(board)
  end
  
  private
  
  def winning_move
    winning_pos = nil
    [0,1,2].each do |row|
      [0,1,2].each do |col|
        pos = [row,col]
        if board.empty?(pos)
          board.place_mark(pos, mark)
          winning_pos = pos if board.winner == mark
          board[pos] = nil
        end
      end
    end
    winning_pos
  end
  
  def random_move
    pos = nil
    pos = [rand(0..2), rand(0..2)] until pos && board.empty?(pos)
    pos
  end
  
end