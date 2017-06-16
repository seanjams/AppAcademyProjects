class Hangman
  attr_reader :guesser, :referee, :board
  MAX_ATTEMPTS = 6
  
  def initialize(players = {})
    defaults = {guesser: HumanPlayer.new, referee: HumanPlayer.new}
    players = defaults.merge(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @attempts = MAX_ATTEMPTS
  end
  
  def setup
    len = referee.pick_secret_word
    guesser.register_secret_length(len)
    @board = "_" * (len)
  end
  
  def take_turn
    display_board
    ch = guesser.guess(board)
    matches = referee.check_guess(ch)
    update_board(ch, matches)
    guesser.handle_response(ch, matches)
    puts ch if guesser.is_a?( ComputerPlayer )
  end
  
  def play
    setup
    until game_over?
      take_turn
    end
    winner = @attempts == 0 ? "Referee": "Guesser"
    puts "Secret word: #{referee.secret_word}   #{winner} wins!"
  end
  
  private
  
  def update_board(ch, matches)
    @attempts -= 1 if matches.empty?
    matches.each { |i| @board[i] = ch }
  end
  
  def display_board
    puts "Secret word: #{board}   attempts remaining: #{@attempts}"
    print "> "
  end
  
  def word_guessed?
    !board.include?("_")
  end
  
  def game_over?
    word_guessed? || @attempts == 0
  end
  
end



class HumanPlayer
  attr_reader :secret_word
  
  def pick_secret_word
    puts "Pick a word: "
    @secret_word = gets.downcase.chomp
    @secret_word.length
  end
  
  def check_guess(letter)
    matches = []
    @secret_word.each_char.with_index do |ch, i|
      matches << i if ch == letter
    end
    matches    
  end
  
  def guess(board)
    gets.downcase[0]
  end
  
  def handle_response(ch, matches)
    nil
  end
  
  def register_secret_length(length)
    nil
  end
end



class ComputerPlayer < HumanPlayer
  attr_reader :candidate_words
  
  def initialize(dictionary)
    @candidate_words = dictionary
  end
  
  def pick_secret_word
    read_words unless candidate_words.is_a?( Array )
    @secret_word = candidate_words.sample
    @secret_word.length
  end
  
  def guess(board)
    letter_counts = Hash.new(0)
    candidate_words.each do |word|
      word.each_char { |ch| letter_counts[ch] += 1 unless board.include?(ch) }
    end
    letter_counts.sort_by {|k,v| v}[-1][0]
  end
  
  def handle_response(ch, matches)
    candidate_words.select! do |word|
      matches.count == word.count(ch) && matches.all? { |i| word[i] == ch }
    end
  end
  
  def register_secret_length(length)
    read_words unless candidate_words.is_a?( Array )
    @candidate_words.select! { |word| word.length == length }
  end
  
  private 
  
  def read_words
    @candidate_words = File.readlines(candidate_words)
    candidate_words.map!(&:chomp)
  end
  
end

if __FILE__ == $PROGRAM_NAME
  print "Referee a Computer(y/n): "
  choice = gets.downcase.chomp
  if choice == "y"
    referee = ComputerPlayer.new("dictionary.txt")
  else
    referee = HumanPlayer.new
  end
  
  print "Guesser a Computer(y/n): "
  choice = gets.downcase.chomp
  if choice == "y"
    guesser = ComputerPlayer.new("dictionary.txt")
  else
    guesser = HumanPlayer.new
  end
  
  game = Hangman.new(guesser: guesser, referee: referee)
  game.play
end