require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display
  attr_reader :board, :cursor

  def initialize(board = Board.new)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    board.grid.each_index do |row|
      row_str = []
      board.grid[row].each_index do |col|
        pos = [row,col]
        tile = board[pos].value ? board[pos].value : " "
        if pos == @cursor.cursor_pos
          if @cursor.selected
            row_str << tile.colorize(:background => :red)
          else
            row_str << tile.colorize(:background => :green)
          end
        else
          row_str << tile
        end
      end
      puts "#{8-row} " + row_str.join(" ")
    end
    puts "  A B C D E F G H"
  end

  def idle_mode
    start_pos, end_pos = nil, nil
    until start_pos
      render
      start_pos = @cursor.get_input
      system("clear")
    end
    until end_pos
      render
      end_pos = @cursor.get_input
      system("clear")
    end
    board.move_piece(start_pos, end_pos)
  rescue
  retry
  end

end

display = Display.new
# display.render
# display.board.move_piece([0,0], [2,2])
loop do
  display.idle_mode

end
# display.render
