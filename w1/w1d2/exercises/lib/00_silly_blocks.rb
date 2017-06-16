def reverser(&prc)
   words = yield.split.map {|str| str.reverse}
   words.join(" ")
end

def adder(n=1, &prc)
    yield + n
end

def repeater(n=1, &prc)
    n.times { yield }
end
