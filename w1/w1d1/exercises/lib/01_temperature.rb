#C = 5/9(F-32)
#F = 9/5(C) + 32

def ctof(c)
  f = (9*c.to_f/5).round(1) + 32
  f == f.floor ? f.floor: f
end

def ftoc(f)
  c = (5*(f.to_f-32)/9).round(1)
  c == c.floor ? c.floor: c
end