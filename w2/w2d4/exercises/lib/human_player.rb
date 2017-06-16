class HumanPlayer
  attr_reader :name
  attr_accessor :mark
  
  def initialize(name = "Human", mark = nil)
    @name = name
    @mark = mark
  end
  
  def get_move
    print "Where, #{name}? (row, col): "
    user_input = gets.chomp
    puts
    user_input.split(",").map(&:to_i)
  end
  
  def display(board)
    marks = []
    board.grid.each do |row|
      marks << row.map { |el| el || " " }
    end
    
    puts "_|_0_|_1_|_2_|"
    puts " |   |   |   |"
    puts "0| #{marks[0][0]} | #{marks[0][1]} | #{marks[0][2]} |"
    puts "_|___|___|___|"
    puts " |   |   |   |"
    puts "1| #{marks[1][0]} | #{marks[1][1]} | #{marks[1][2]} |"
    puts "_|___|___|___|"    
    puts " |   |   |   |"
    puts "2| #{marks[2][0]} | #{marks[2][1]} | #{marks[2][2]} |"
    puts "_|___|___|___|"
    puts
  end
  
end