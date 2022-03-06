# frozen_string_literal: true

module CSpec
  module Validator
    def self.validate(headers)
      %w[class type name method expected].map do |required_header|
        "Need header: #{required_header}" unless headers.include?(required_header)
      end.reject(&:nil?)
    end
  end
end
