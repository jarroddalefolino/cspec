# frozen_string_literal: true

require 'cspec'
require 'logging'
require_relative 'number_guessing_game'

result = CSpec::Runner.run!("#{Dir.pwd}/specs.csv")
exit result ? 0 : 1
