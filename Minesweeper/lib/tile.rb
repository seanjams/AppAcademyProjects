class Tile
  attr_accessor :value, :hidden

  def initialize(value = "X")
    @value = value
    @hidden = true
  end

  def reveal
    @hidden = false if @hidden
  end

  def to_s
    hidden ? '_' : value
  end



end
