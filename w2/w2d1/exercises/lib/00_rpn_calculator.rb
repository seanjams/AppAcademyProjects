#!/usr/bin/env ruby

class RPNCalculator
  
  def initialize
    @nums = []
  end
  
  def push(i)
    @nums << i 
  end
  
  def value
    @nums.last || 0
  end
  
  def plus
    rhs  = strip_rhs
    @nums[-1] += rhs
  end
  
  def minus
    rhs  = strip_rhs
    @nums[-1] -= rhs
  end
  
  def times
    rhs  = strip_rhs
    @nums[-1] *= rhs
  end
  
  def divide
    rhs  = strip_rhs
    @nums[-1] = @nums[-1].fdiv(rhs) 
  end
 
  def evaluate(str)
    tokens(str).each do |tok|
      case tok
        when :+ then plus
        when :- then minus 
        when :* then times
        when :/ then divide
        else push(tok)
      end 
    end
    value
  end
  
  def tokens(str)
    toks = []
    str.split.each do |ch|
      /[0-9]/.match(ch) ? toks << ch.to_i: toks << ch.to_sym
    end
    toks
  end
  
  def get_user_instructions
    instructions = []
    until instructions.last == ""
      print "> "
      instructions << gets.chomp
    end
    instructions[0..-2].join(" ")
  end
  
  private
  
  def strip_rhs
    raise "calculator is empty" if @nums.count < 2
    @nums.pop
  end
  
end

if __FILE__ == $PROGRAM_NAME
  if ARGV[0]
    instructions = File.readlines("calculator_instructions.txt")
    instructions.each do |line|
      calc = RPNCalculator.new
      puts ">> #{calc.evaluate(line)}"
    end
  else
    calc = RPNCalculator.new
    puts ">> #{calc.evaluate(calc.get_user_instructions)}"
  end
end