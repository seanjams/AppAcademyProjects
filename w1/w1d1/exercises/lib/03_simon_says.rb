def echo(str)
  str
end

def shout(str)
  str.upcase
end

def repeat(str, n=2)
  repeats = Array.new(n, str)
  repeats.join(" ")
end

def start_of_word(str, n)
  str[0...n]
end

def first_word(str)
  str.split[0]
end

def titleize(str)
  little_words = ["a","an","the","and","but",
                  "for","nor","or","on","at",
                  "to","from","by","over"]
  words = str.split
  words.each_with_index do |word, i|
    word.capitalize! if i == 0 || !little_words.include?(word)
  end
  words.join(" ")
end
