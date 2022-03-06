# frozen_string_literal: true

module CSpec
  module DataType
    def self.convert_all(inputs)
      return nil unless inputs

      inputs.map { |input| convert(input) }
    end

    def self.convert(input)
      return input unless input.instance_of?(String)

      input = input.strip
      return input.to_f if input =~ /^\d+\.\d+$/
      return input.to_i if input =~ /^\d+$/
      return eval(input) if input =~ /^\[.*\]$/
      return nil if ['', nil, 'nil'].include?(input)

      input.to_s
    end
  end
end
