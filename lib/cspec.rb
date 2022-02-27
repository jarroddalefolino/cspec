# frozen_string_literal: true

require 'cspec/version'
require 'csv'
require_relative 'result'

module CSpec
  module ResultsOutputter
    def self.display(results)
      results.each do |r|
        puts r
      end
    end
  end

  module Loader
    def self.load(filename)
      ::CSV.open(filename, headers: :first_row).map(&:to_h)
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

  module Executer
    def self.do_instance(spec)
      class_under_test = Object.const_get(spec[:class])
      instance_under_test = class_under_test.new(*spec[:initialize_params])
      puts spec[:method_args]
      instance_under_test.send(spec[:method], *spec[:method_args])
    end

    def self.do_class(spec)
      class_under_test = Object.const_get(spec[:class])
      class_under_test.send(spec[:method], *spec[:method_args])
    end
  end

  module DataType
    def self.convert(input)
      if input =~ /^\d+\.\d+$/
        input.to_f
      elsif input =~ /^\d+$/
        input.to_i
      elsif input =~ /^\[.*\]$/
        eval(input)
      elsif ['', nil, 'nil'].include?(input)
        nil
      else
        input.to_s
      end
    end
  end

  module Runner
    def self.run!(filepath)
      errors = Loader.validate(filepath)
      if errors.size != 0
        puts errors
        return false
      end
      specs = Loader.load(filepath)
      results = run(specs)

      ResultsOutputter.display(results)
      if CSpec::Result.success?(results)
        return true
      else
        return false
      end
    end

    def self.run(specs)
      results = []
      specs.each do |spec|
        result = case spec[:type]
                 when 'class'
                   ::CSpec::Executer.do_class(spec)
                 when 'instance'
                   ::CSpec::Executer.do_instance(spec)
                 end

        result = ::CSpec::DataType.convert(result)
        results << if result == ::CSpec::DataType.convert(spec[:expected])
                     Result.new(spec[:name], spec[:class], spec[:method], nil, spec[:description], nil)
                   else
                     puts 'here'
                     Result.new(spec[:name], spec[:class], spec[:method],
                                "Expected #{spec[:expected]}, got: #{result}", spec[:description], nil)
                   end
      rescue StandardError => e
        results << Result.new(spec[:name], spec[:class], spec[:method], e.inspect, spec[:description], nil)
      end
      results
    end
  end
end
