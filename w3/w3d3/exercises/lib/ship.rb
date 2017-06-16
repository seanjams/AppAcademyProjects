class Ship
  attr_reader :length
  
  def initialize(length, start_pos, direction)
    @length = length
    @start_pos = start_pos
    @direction = direction
  end
  
  def self.random(length)
    rand_pos = [rand(0..9), rand(0..9)]
    rand_dir = ["horz", "vert"].sample
    Ship.new(length, rand_pos, rand_dir)
  end
  
  def pegs
    a,b = @start_pos
    pegs_arr = []
    (0...length).each do |i|
      if @direction == "horz"
        pegs_arr << [a, b+i]
      elsif @direction == "vert"
        pegs_arr << [a+i, b]
      end
    end
    pegs_arr
  end
  
end