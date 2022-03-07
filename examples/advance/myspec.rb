# frozen_string_literal: true

require 'cspec'

class MyClass
  def greet(fname, sname)
    "Hello, #{fname} #{sname}"
  end
end

class Util
  def build_array(val1, val2, val3)
    [val1, val2, val3]
  end

  def sum_array(array)
    array.sum
  end
end

class Calculator
  def self.add(val1, val2)
    val1 + val2
  end

  def self.multi_subtract(val1, val2, val3)
    val1 - val2 - val3
  end
end

result = CSpec::Runner.run!("#{Dir.pwd}/specs.csv")
puts "Success: #{result}"
exit result ? 0 : 1
