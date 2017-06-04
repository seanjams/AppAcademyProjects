class HumanPlayer

  def get_guess
    puts "pick first guess: "
    guess1 = gets.chomp.split(',').map(&:to_i)
    puts "pick second guess: "
    guess2 = gets.chomp.split(',').map(&:to_i)
    [guess1, guess2]
  end

end

class ComputerPlayer
  attr_accessor :moves, :board

  def initialize
    @moves = Hash.new(Array.new)
  end

  def calculate_guess
    @moves.keys.each do |letter|
      pos_arr = @moves[letter]
      if pos_arr.count == 2 && pos_arr.any? { |pos| !board[pos].faceup }
        @moves[letter] = pos_arr.reverse
        return @moves[letter][0]
      end
    end
    pick_random
  end

  def add_move(pos)
    letter = board[pos].value #debugger
    @moves[letter] += [pos] unless @moves[letter].include?(pos)
  end

  def get_guess
    guess1 = calculate_guess
    guess2 = calculate_guess
    guess2 = calculate_guess until guess1 != guess2
    add_move(guess1)
    add_move(guess2)
    puts @moves.to_s
    [guess1, guess2]
  end

  def pick_random
    lim = board.grid.length
    [rand(0...lim), rand(0...lim)]
  end

end
