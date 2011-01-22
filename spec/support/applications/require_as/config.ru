require 'rubygems'
require 'active_support'

run lambda { |e| [ 200, { 'Content-Type' => 'text/plain' }, [ ActiveSupport.to_s ] ] }
