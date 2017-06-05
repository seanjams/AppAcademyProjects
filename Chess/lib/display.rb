require_relative 'board'
require_relative 'cursor'
#require 'colorize'

class Display
  attr_reader :board

  def initialize(board = Board.new)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    board.grid.each_index do |row|
      board.grid[row].each_index do |col|
        pos = [row,col]
        print board[pos] ? board[pos].value : " "
      end
      puts
    end
  end

end

display = Display.new
display.render
