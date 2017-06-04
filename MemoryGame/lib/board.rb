class Board
  ALPHABET = ("A".."Z").to_a
  attr_reader :grid

  def initialize(n)
    @grid = Array.new(n) { Array.new(n) }
    @cards = []
  end

  def [](pos)
    a,b = pos
    @grid[a][b]
  end

  def []=(pos, value)
    a,b = pos
    @grid[a][b] = value
  end

  def populate
    num_pairs = @grid.length * @grid[0].length/2

    (1..num_pairs).each do |i|
      2.times { @cards << Card.new(ALPHABET[i]) }
    end

    @cards.shuffle!

    (0...@grid.length).each do |row|
      (0...@grid[0].length).each do |col|
        pos = [row, col]
        self[pos] = @cards.pop
      end
    end

  end

  def render
    (0...@grid.length).each do |row|
      (0...@grid[0].length).each do |col|
        pos = [row, col]
        self[pos].display
      end
      puts
    end
  end


  def won?
    @grid.all? do |row|
      row.all? do |card|
        card.faceup
      end
    end
  end

end
