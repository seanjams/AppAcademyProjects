

class Card

  attr_reader :value, :faceup

  def initialize(value)
    @faceup = false
    @value = value
  end

  def display
    print @faceup ? "#{@value} " : "X "
  end

  def flip!
    @faceup = !@faceup
  end

  def ==(other_card)
    @value == other_card.value
  end

  def to_s
    @value.to_s
  end

end
