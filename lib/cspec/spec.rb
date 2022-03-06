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

    def to_s
      "name: #{name}, class: #{self.class}, method: #{method},"
    end
  end
end
