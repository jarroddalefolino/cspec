# frozen_string_literal: true

require 'cspec'

class MyClass
  def self.hello
    'world'
  end

  def self.say(name)
    "Hello, #{name}"
  end
end

result = CSpec::Runner.run!("#{Dir.pwd}/specs.csv")
puts "Success: #{result}"
exit result ? 0 : 1
