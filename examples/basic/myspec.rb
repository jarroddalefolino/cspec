# frozen_string_literal: true

require 'cspec'

class MyClass
  def hello
    'world'
  end

  def hello2(param1)
    "world2#{param1}"
  end
end

result = CSpec::Runner.run!("#{Dir.pwd}/specs.csv")
puts "Success: #{result}"
exit result ? 0 : 1
