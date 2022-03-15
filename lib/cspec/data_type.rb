# frozen_string_literal: true

module CSpec
  module DataType
    MATCHERS = [
      { condition: /^\d+\.\d+$/, proc: proc { |input| input.to_f } },
      { condition: /^\d+$/, proc: proc { |input| input.to_i } },
      { condition: /true/, proc: proc { true } },
      { condition: /^\[.*\]$/, proc: proc { |input| eval(input) } },
      { condition: /false/, proc: proc { false } },
      { condition: /nil/, proc: proc { nil } },
      { condition: /^$/, proc: proc { nil } }
    ].freeze

    def self.convert_all(inputs)
      return nil unless inputs

      inputs.map { |input| convert(input) }
    end

    def self.convert(input)
      return input unless input.instance_of?(String)

      input = input.strip
      MATCHERS.each do |matcher|
        return matcher[:proc].call(input) if input.match?(matcher[:condition])
      end

      input.to_s
    end
  end
end
