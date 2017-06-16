class Temperature
  attr_accessor :temp
  
  def initialize(temp = {})
    @temp = temp
  end
  
  def in_fahrenheit
    temp[:f] || (9*temp[:c])*0.2 + 32
  end
  
  def in_celsius
    temp[:c] || 5*(temp[:f]-32).fdiv(9)
  end
  
  def self.from_fahrenheit(deg_f)
    self.new(:f => deg_f)  
  end
  
  def self.from_celsius(deg_c)
    self.new(:c => deg_c)   
  end
  
end

class Fahrenheit < Temperature
  
  def initialize(deg_f)
    self.temp = {:f => deg_f}
  end
  
end

class Celsius < Temperature
  
  def initialize(deg_c)
    self.temp = {:c => deg_c}
  end
  
end
