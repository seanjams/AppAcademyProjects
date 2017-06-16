# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
  num, guesses, guess = rand(1..100), [], 0
  until guess == num
    guess = user_input
    guesses << guess
    print_result(guess, num)
  end
end

def user_input
  print "Guess a number: "
  gets.chomp.to_i
end

def print_result(guess, num)
  if guess > num
    puts "#{guess} is too high"
  elsif guess < num
    puts "#{guess} is too low"
  else
    puts "Jackpot! The number was #{num}."
    puts "# of tries: #{guesses.count}"
    puts "guesses: #{guesses}"
  end  
end

def shuffle_file
  puts "Enter file to be shuffled: "
  filename = gets.chomp
  base = File.basename(filename, ".*")
  ext = File.extname(filename)
  new_file = File.open("#{base}-shuffled#{ext}", "w")
  File.readlines(filename).shuffle.each { |line| new_file.puts(line) }
end
