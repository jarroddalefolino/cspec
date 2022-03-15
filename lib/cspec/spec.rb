# frozen_string_literal: true

module CSpec
  class Spec
    attr_reader :class,
                :name,
                :type,
                :method,
                :method_args,
                :initialization_args,
                :expected

    def initialize(hash)
      @class = hash['class']
      @name = hash['name']
      @type = hash['type']
      @method = hash['method']
      @method_args = ::CSpec::DataType.convert_all(hash['method_args'])
      @initialization_args = ::CSpec::DataType.convert_all(hash['initialization_args'])
      @expected = hash['expected']
    end

    def ==(other)
      name == other.name &&
        self.class == other.class &&
        method == other.method &&
        type == other.type &&
        method_args == other.method_args &&
        initialization_args == other.initialization_args
    end

    def error
      return ["#{self.class} does not exist"] unless Object.const_defined?(self.class)

      errors = []

      errors += send("#{type}_errors")

      errors.size.positive? ? errors.flatten : nil
    end

    def to_s
      "name: #{name}, class: #{self.class}, method: #{method}, method_args: #{method_args}"
    end

    private

    def class_errors
      if Object.const_get(self.class).respond_to?(method.to_sym)
        []
      else
        ["#{type} method: #{self.class}##{method} does not exist"]
      end
    end

    def instance_errors
      if !Object.const_get(self.class)&.method_defined?(method.to_sym)
        ["#{type} method: #{self.class}##{method} does not exist"]
      else
        []
      end
    end
  end
end
