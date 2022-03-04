# frozen_string_literal: true

module CSpec
  module Loader
    def self.load(filename)
      ::CSV.open(filename, headers: :first_row).map(&:to_h)
    end

    def self.process_args(spec)
      process_arg(spec, /method_arg_\d+/, 'method_args').merge(
        process_arg(spec, /initialization_arg_\d+/, 'initialization_args')
      )
    end

    def self.process_arg(spec, regex, aggregate_key)
      spec.merge({
                   aggregate_key => spec.keys
                 .select { |k| k.match?(regex) }
                 .inject([]) { |values, key| values << spec[key] }
                 })
    end

    def self.validate(filename)
      headers = CSV.open(filename, &:readline)
      %w[class type name method expected].map do |required_header|
        "Need header: #{required_header}" unless headers.include?(required_header)
      end.reject(&:nil?)
    end
  end
end
