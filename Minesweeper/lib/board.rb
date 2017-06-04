require_relative 'tile'
require 'byebug'

class Board
  attr_reader :bombs

  def initialize
    @grid = Array.new(9) { Array.new(9) { Tile.new } }
    @bombs = []
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, mark)
    x, y = pos
    @grid[x][y] = mark
  end

  def make_bombs
    until @bombs.size == 10
      bomb = all_positions.sample
      @bombs << bomb unless @bombs.include?(bomb)
    end

    @bombs.each do |pos|
      self[pos].value = "*"
    end

  end

  def render
    # puts "  #{(0..8).to_a.join("|")}"
    # @grid.each_with_index do |row, i|
    #   puts "#{i} #{row.join(" ")}"
    # end
    (0..8).each do |i|
      puts @grid[i].map(&:to_s).join("|")
      # (0..8).each do |col|
      #   print self[[row, col]].to_s
      # end
      # puts
    end




  end

  def all_positions
    result = []
    (0..@grid.size - 1).each do |row|
      (0..@grid.size - 1).each do |col|
        result << [row, col]
      end
    end
    result
  end

end
