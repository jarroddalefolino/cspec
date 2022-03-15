# frozen_string_literal: true

module CSpec
  module Validator
    def self.validate_structure(headers)
      %w[class type name method expected].map do |required_header|
        "Need header: #{required_header}" unless headers.include?(required_header)
      end.reject(&:nil?)
    end

    def self.validate_specs(specs)
      specs.map(&:error).reject(&:nil?).flatten
    end
  end
end
