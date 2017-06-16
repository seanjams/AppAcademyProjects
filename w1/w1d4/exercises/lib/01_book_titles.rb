class Book
  LITTLE_WORDS = ["the", "a", "an", "and", "in", "of"]
  attr_reader :title
  
  def title=(name)
    title_words = name.downcase.split
    new_title = title_words.map.with_index do |word, i|
      LITTLE_WORDS.include?(word) && i != 0 ? word: word.capitalize
    end
    @title = new_title.join(" ")
  end
  
end
