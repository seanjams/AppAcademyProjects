class Fixnum
  ONES = ["zero", "one", "two", "three", "four",
          "five", "six", "seven", "eight", "nine"]
          
  TEENS = ["ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen",
           "sixteen", "seventeen", "eighteen", "nineteen"]

  TENS = ["twenty", "thirty", "forty", "fifty",
          "sixty", "seventy", "eighty", "ninety"]
          
  LARGE_NUMS = ["thousand", "million", "billion", "trillion"]
    
    
  def in_words
    return "zero" if self == 0
    word_chunks = []
    chunks_of_three.each_with_index do |chunk, i|
        word_chunks << LARGE_NUMS[i-1] unless i == 0 || chunk == 0
        word_chunks << chunk.string_builder
    end
    word_chunks.compact.reverse.join(" ")
  end
  
  def string_builder  #returns string
    case self
    when 0 then return nil
    when (1..9) then words = [ONES[grab_idx(0)]]
    when (10..19) then words = [TEENS[grab_idx(1)]]
    when (20..99)
      words = [TENS[grab_idx(0)-2], grab_idx(1,-1).string_builder]
    when (100..999) 
      words = [ONES[grab_idx(0)], "hundred", grab_idx(1,-1).string_builder]
    else
      raise "string builder out of range"
    end
    words.compact.join(" ")
  end
  
  private
  
  def chunks_of_three  #returns an array of ints representing comma separation of a num
    chunks, chunk = [], []
    to_s.reverse.each_char.with_index do |ch, i|
      chunk << ch
      if (i+1)%3 == 0 || i+1 == to_s.length
        chunks << chunk.join.reverse.to_i
        chunk = []
      end
    end
    chunks
  end
  
  def grab_idx(first_idx, last_idx=first_idx) #returns int
    to_s[first_idx..last_idx].to_i  
  end

end