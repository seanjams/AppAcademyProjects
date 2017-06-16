def add(a,b)
  a + b
end

def subtract(a,b)
  a - b
end

def sum(arr)
  arr.empty? ? 0: arr.reduce(:+)
end

=begin
def multiply(a,b)
  a*b
end

def power(a,b)
  a**b
end

def factorial(n)
  return 1 if n==0
  return nil if n<0
  (1..n).to_a.reduce(:*)
end
=end
