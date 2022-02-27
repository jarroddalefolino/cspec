# frozen_string_literal: true

module CSpec
  class Result
    attr_reader :name, :class, :method, :error, :description, :details

    def self.success?(results)
      results.count { |r| !r.error.nil? }.zero?
    end

    def initialize(name, klass, method, error, description, details)
      @name = name
      @error = error
      @class = klass
      @method = method
      @description = description
      @details = details
    end

    def ==(other)
      name == other.name &&
        self.class == other.class &&
        method == other.method &&
        error == other.error &&
        description == other.description &&
        details == other.details
    end

    def to_s
      "name: #{name}, class: #{self.class}, method: #{method}, error: #{error}, description: #{description}, details: #{details}"
    end
  end
end
