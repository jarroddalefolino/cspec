# frozen_string_literal: true

require 'cspec'

class MyClass
  def greet(name)
    "Hello, #{name}"
  end
end

result = CSpec::Runner.run!("#{Dir.pwd}/specs.csv")
exit result ? 0 : 1
