VOWELS = "aeiou".chars

def pig(word)
  word = word.downcase.chars
  until VOWELS.include?(word[0])
    word[0..1] == ["q","u"] ? word.rotate!(2): word.rotate!
  end
  word.join + "ay"
end

def translate(string)
  pig_sentence = string.split.map! { |word| pig(word) }
  pig_sentence.join(" ")
end
    
