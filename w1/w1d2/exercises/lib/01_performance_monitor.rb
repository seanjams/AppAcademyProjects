def measure(n=1, &prc)
    trials = []
    n.times do 
        start_time = Time.now
        yield
        trials << Time.now - start_time
    end
    trials.reduce(:+).fdiv(trials.length)
end