# Cspec

## Running test cases via CSV

The goal of this project is to have a centralised location where all specs can be run

## Quick start

* Add this to your `Gemfile`
```ruby
  gem 'cspec'
```
* Create a CSV named `specs.csv` with the following spec
```csv
class,name,type,initialization_arg_1,method,method_arg_1,expected
MyClass,my test,,hello,,world
```
* Create a file named `my_csv_specs.rb` to run the specs
```ruby
require 'cspec'

# The implementation of the Ruby class being testedc
class MyClass
  def hello
    'world'
  end
end

# Running the specs
result = CSpec::Runner.run!("#{Dir.pwd}/specs.csv")
puts "Success: #{result}"
```

* Run with `ruby my_csv_specs.rb`
