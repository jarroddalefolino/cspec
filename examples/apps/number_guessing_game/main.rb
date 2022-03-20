# frozen_string_literal: true

require_relative 'number_guessing_game'

number = rand(InputValidator.new.maximum)
puts "Guess a number between #{InputValidator.new.minimum} and #{InputValidator.new.maximum}"
active = true
while active
  guess = $stdin.gets

  error = InputValidator.new.get_error(guess)
  if error
    puts error
  else
    result = NumberGuess.new.guess(InputConverter.new.convert(guess), number)
    puts result
    active = false if result == 'correct'
  end
end
