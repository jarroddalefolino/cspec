# frozen_string_literal: true

class NumberUtil
  def largest(num1, num2)
    return num1 if num1 > num2

    num2
  end
end

class StringUtil
  def greet(name)
    "Hello, #{name}"
  end
end

class CokeMachine
  def initialize(inventory_amount)
    @inventory_amount = inventory_amount
  end

  attr_reader :inventory_amount
end

class GradingMachine
  def pass?(amount)
    return false if amount < 45

    true
  end

  def grade(amount)
    if amount < 45
      'F'
    elsif amount >= 45 && amount < 60
      'E'
    elsif amount >= 60 && amount < 70
      'D'
    elsif amount >= 70 && amount < 80
      'C'
    elsif amount >= 80 && amount < 90
      'B'
    elsif amount >= 90
      'A'
    end
  end
end
