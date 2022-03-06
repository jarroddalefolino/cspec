# frozen_string_literal: true

module CSpec
  module CodeExec
    def self.do_instance(spec)
      class_under_test = Object.const_get(spec.class)
      instance_under_test = class_under_test.new(*spec.initialization_args)
      instance_under_test.send(spec.method, *spec.method_args)
    end

    def self.do_class(spec)
      class_under_test = Object.const_get(spec.class)
      class_under_test.send(spec.method, *spec.method_args)
    end

    def self.do(spec)
      case spec.type
      when 'class'
        do_class(spec)
      when 'instance'
        do_instance(spec)
      end
    end
  end
end
