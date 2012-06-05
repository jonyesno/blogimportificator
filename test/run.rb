#!/usr/bin/env ruby
#
$:.unshift("#{File.dirname(__FILE__)}/../lib")
$:.unshift(File.dirname(__FILE__))

require 'pp'

Dir['test_*.rb'].each do |test|
  puts "#{test}"
  require test
end

__END__
# test blog list, with fuzz
Foo Bar,bar@example.com
,,
,woo

Woo Yay,
