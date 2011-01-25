require 'openssl'
require 'active_record'
require 'arjdbc/mysql'
require 'arjdbc/postgresql'

run lambda { |e| [ 200, {'Content-Type' => 'text/plain'}, ['Hello World'] ] }
