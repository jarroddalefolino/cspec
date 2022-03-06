# frozen_string_literal: true

require_relative 'spec'

module CSpec
  module Loader
    def self.load(filename)
      specs = ::CSV.open(filename, headers: :first_row).map(&:to_h)
      specs.map { |spec| ::CSpec::Spec.new(process_args(spec)) }
    end

    def self.process_args(spec)
      process_arg(spec, /method_arg_\d+/, 'method_args').merge(
        process_arg(spec, /initialization_arg_\d+/, 'initialization_args')
      )
    end

    def self.process_arg(spec, regex, aggregate_key)
      spec.merge({
                   aggregate_key => spec.keys
                 .select { |k| k.match?(regex) && !spec[k].nil? }
                 .inject([]) { |values, key| values << spec[key] }
                 })
    end

    def self.validate(filename)
      headers = CSV.open(filename, &:readline)
      ::CSpec::Validator.validate(headers)
    end
  end
end
