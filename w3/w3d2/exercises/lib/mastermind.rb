class Code
  attr_reader :pegs
  
  PEGS = {"r" => :red, "g" => :green, "b" => :blue,
          "y" => :yellow, "o" => :orange, "p" => :purple}
  
  def initialize(pegs)
    @pegs = pegs[0..3]
  end
  
  def self.random
    Code.new( Array.new(4) { PEGS.keys.sample } )
  end
  
  def self.parse(guess)
    code = guess.downcase.chars
    raise("invalid character") unless code.all? { |ch| PEGS.keys.include?(ch) }
    Code.new( code )
  end

  def exact_matches(code)
    count = 0
    pegs.each_index do |i|
      count += 1 if pegs[i] == code.pegs[i]
    end
    count
  end
  
  def near_matches(code)
    near_count = pegs.uniq.reduce(0) do |sum, color|
      sum + [pegs.count(color), code.pegs.count(color)].min
    end
    near_count - exact_matches(code)
  end
    
  def [](idx)
    pegs[idx]
  end
  
  def ==(code)
    return false unless code.is_a?(Code)
    (0..3).all? { |i| self.pegs[i] == code.pegs[i] }
  end
  
end




class Game
  attr_reader :secret_code
  
  def initialize(code = Code.random)
    @secret_code = code
  end
  
  def get_guess
    print "Guess the code (RGBYOP): "
    guess = gets.chomp
    guess.length == 4 ? Code.parse(guess): Code.random
  end
  
  def display_matches(guess)
    exact_count = secret_code.exact_matches(guess)
    near_count = secret_code.near_matches(guess)
    puts "exact: #{exact_count}  near: #{near_count}"
  end
  
  def play
    puts "///MASTERMIND///"
    
    10.times do
      guess = get_guess
      if guess == secret_code
        puts "You win!! Secret Code: #{secret_code.pegs.to_s}"
        return
      end
      display_matches(guess)
    end
    
    puts "You Lose!! Secret Code: #{secret_code.pegs.to_s}"
  end
  
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end

ARGV.clear
