# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp.html) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

class TowersOfHanoi
    attr_reader :towers
    
    def initialize(size = 3)
      @towers = Array.new(size, [])
      @towers[0] = (1..size).to_a.reverse
    end
    
    def play
      until won? 
        display_towers
        from_pile, to_pile = get_input
        move(from_pile, to_pile) if valid_move?(from_pile, to_pile)
      end
      puts "You win!"
    end
    
    def valid_move?(from_pile, to_pile)
      return false if towers[from_pile].empty?
      towers[to_pile].empty? || towers[to_pile].last > towers[from_pile].last 
    end
    
    def won?
      towers[0].empty? && towers[1..-1].any? {|tower| tower.empty?}
    end
    
    def move(from_pile, to_pile)
      disk = towers[from_pile].pop
      towers[to_pile] += [disk]
    end
    
    def display_towers
      puts
      @towers.each_with_index do |tower, i|
        puts "Tower #{i}: #{tower.to_s}"
      end
      puts
    end
    
    private
    
    def get_input
      print "From tower?: "
      from_pile = gets.chomp.to_i
      print "To tower?: "
      to_pile = gets.chomp.to_i
      [from_pile, to_pile]
    end
    
end

if __FILE__ == $PROGRAM_NAME
  print "Number of towers?: "
  towers = gets.chomp.to_i
  game = TowersOfHanoi.new(towers)
  game.play
end
