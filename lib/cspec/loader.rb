# frozen_string_literal: true

module CSpec
  module Loader
    def self.load(filename)
      ::CSV.open(filename, headers: :first_row).map(&:to_h)
    end

    def self.process_args(spec)
      spec = process_arg(spec, /method_arg_\d+/, 'method_args')
      process_arg(spec, /initialization_arg_\d+/, 'initialization_args')
    end

    def self.process_arg(spec, regex, aggregate_key)
      all_keys = spec.keys.select { |k| k.match?(regex) }
      combined = all_keys.inject([]) do |values, key|
        values << spec[key]
      end
      spec.merge({ aggregate_key => combined })
    end

    def self.validate(filename)
      errors = []
      headers = CSV.open(filename, &:readline)
      %w[class type name method expected].each do |required_header|
        errors << "Need header: #{required_header}" unless headers.include?(required_header)
      end
      errors
    end
  end
end
