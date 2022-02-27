require 'cspec'

class MyClass
  def hello
    'world'
  end
end

result = CSpec::Runner.run!("#{Dir.pwd}/specs.csv")
puts "Success: #{result}"