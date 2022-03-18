# frozen_string_literal: true

require 'cspec'
require 'logging'

# Logger setup
class Object
  def logger_info
    "#{self.class}##{__callee__} (#{object_id})"
  end
end

class MyLogger
  def self.instance
    return @logger if @logger

    @logger = Logging.logger($stdout)
    @logger.level = ENV['LOG_LEVEL']&.to_sym || :warn
    @logger.add_appenders \
      Logging.appenders.stdout,
      Logging.appenders.file("#{Time.now.strftime('%Y%m%d')}.log")
    @logger
  end
end

class NumberUtil
  def largest(num1, num2)
    return num1 if num1 > num2

    num2
  end

  def sum_number_range(start_num, end_num)
    MyLogger.instance.debug("#{logger_info} start_num: #{start_num}, end_num: #{end_num}")
    x = start_num
    sum = 0
    MyLogger.instance.debug("#{logger_info} #{x} <= #{end_num}: #{x <= end_num}")
    while x <= end_num
      MyLogger.instance.debug("#{logger_info} #{x} <= #{end_num}: #{x <= end_num}")
      sum += x
      MyLogger.instance.debug("#{logger_info} sum: #{sum}")
      x += 1
    end
    sum
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

result = CSpec::Runner.run!("#{Dir.pwd}/specs.csv")
exit result ? 0 : 1
