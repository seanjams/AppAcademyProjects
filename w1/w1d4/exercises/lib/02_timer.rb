class Timer
  attr_accessor :seconds
  
  def initialize(seconds=0)
    @seconds = seconds
  end
    
    
  def time_string
    time_numbers = []
    [0,1,2].each { |i| time_numbers << (seconds/60**i) % 60 }
    get_string(time_numbers)
    
  end
  
  private
  
  def get_string(nums)
    strings = nums.map { |num| num < 10 ? "0#{num}" : "#{num}" }
    "#{strings[2]}:#{strings[1]}:#{strings[0]}"
  end
  
end