# frozen_string_literal: true

class Calculator
  def initialize(starting_number)
    @starting_number = starting_number
  end

  def add(amount)
    @starting_number + amount
  end

  def add_more(amount, amount2)
    @starting_number + amount + amount2
  end

  def self.add(val1, val2)
    val1 + val2
  end

  def self.multi_subtract(val1, val2, val3)
    val1 - val2 - val3
  end
end

class CalculatorClass
  def self.subtract(num1, num2)
    num1 - num2
  end
end

class StringHelper
  def self.letter_count(word)
    word.size
  end
end

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
