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
