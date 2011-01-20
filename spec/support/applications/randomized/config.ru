RAND = rand(10_000)

run lambda { |e| [ 200, { 'Content-Type' => 'text/plain' }, [ RAND.to_s ] ] }
