# frozen_string_literal: true

require 'cspec/version'
require 'cspec/runner'
require 'cspec/loader'
require 'cspec/result'

require 'csv'

module CSpec
  module ResultsOutputter
    def self.display(results)
      results.each do |r|
        puts r
      end
    end
  end

  module Executer
    def self.do_instance(spec)
      class_under_test = Object.const_get(spec['class'])
      instance_under_test = class_under_test.new(*spec['initialization_args'])
      instance_under_test.send(spec['method'], *spec['method_args'])
    end

    def self.do_class(spec)
      class_under_test = Object.const_get(spec['class'])
      class_under_test.send(spec['method'], *spec['method_args'])
    end

    def self.do(spec)
      case spec[:type]
      when 'class'
        do_class(spec)
      when 'instance'
        do_instance(spec)
      end
    end
  end

  module DataType
    def self.convert(input)
      return input.to_f if input =~ /^\d+\.\d+$/
      return input.to_i if input =~ /^\d+$/
      return eval(input) if input =~ /^\[.*\]$/
      return nil if ['', nil, 'nil'].include?(input)

      input.to_s
    end
  end
end
