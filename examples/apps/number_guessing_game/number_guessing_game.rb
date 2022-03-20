# frozen_string_literal: true

# Logger setup
class Object
  def logger_info
    "#{self.class}##{__callee__} (#{object_id})"
  end
end

class NumberGuess
  def guess(guess, number)
    return 'number is lower' if guess > number
    return 'number is higher' if guess < number
    return 'correct' if guess == number
  end
end

class InputConverter
  def convert(input)
    input = input.strip if input.instance_of?(String)
    input.to_i
  end
end

class InputValidator
  def get_format_error(input)
    if input.to_s =~ /\d+/
      nil
    else
      'Please enter a valid number'
    end
  end

  def get_range_error(input)
    input = input.to_i
    return 'Please enter a number lower than or equal to 100' if input < minimum
    return 'Please enter a number lower than or equal to 100' if input > maximum

    nil
  end

  def get_error(input)
    format_error = get_format_error(input)
    return format_error if format_error

    range_error = get_range_error(input)
    return range_error if range_error

    nil
  end

  def maximum
    100
  end

  def minimum
    1
  end
end
