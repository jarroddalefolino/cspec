require 'cspec/version'

module CSpec
  module Executer
    def self.do_instance(spec)
      class_under_test = Object.const_get(spec[:class])
      instance_under_test = class_under_test.new(*spec[:initialize_params])
      instance_under_test.send(spec[:method], *spec[:method_args])
    end

    def self.do_class(spec)
      class_under_test = Object.const_get(spec[:class])
      class_under_test.send(spec[:method], *spec[:method_args])
    end
  end

  module DataType
    def caster(result, cast_type)
      if cast_type == 'Integer'
        result.to_i
      elsif cast_type == 'String'
        result.to_s
      elsif cast_type.nil?
        result
      else
        result
      end
    end
  end

  module Runner
    def run(specs)
      errors = []
      successes = []
      specs.each do |spec|
        result = if spec[:type] == 'class'
                   do_class(spec)
                 elsif spec[:type] == 'instance'
                   do_instance(spec)
                 end

        result = caster(result, spec[:expected_type])
        if result == spec[:expected]
          successes << spec[:description]
        else
          errors << {
            description: spec[:description],
            details: "Expected #{spec[:expected]}, got: #{result}"
          }
        end
      rescue StandardError => e
        errors << {
          description: spec[:description],
          details: e.inspect
        }
      end
    end
  end
end
