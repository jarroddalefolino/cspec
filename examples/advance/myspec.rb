# frozen_string_literal: true

require 'cspec'

class MyClass
  def greet(fname, sname)
    "Hello, #{fname} #{sname}"
  end
end

result = CSpec::Runner.run!("#{Dir.pwd}/specs.csv")
puts "Success: #{result}"
exit result ? 0 : 1
