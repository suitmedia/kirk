use Rack::Lint

run lambda { |env|
  obj = env.dup

  if input = env['rack.input']
    obj['rack.input'] = input.read
  end

  if io = env['rack.errors']
    obj['rack.errors'] = true
  end

  [ 200, { 'Content-Type' => 'application/x-ruby-object' }, [ Marshal.dump(obj) ] ]
}
