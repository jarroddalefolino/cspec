# frozen_string_literal: true

module CSpec
  class Result
    attr_reader :spec, :error

    def self.success?(results)
      results.count { |r| !r.error.nil? }.zero?
    end

    def self.from_spec(spec, error = nil)
      Result.new(spec, error)
    end

    def initialize(spec, error)
      @spec = spec
      @error = error
    end

    def ==(other)
      error == other.error &&
        spec == other.spec
    end

    def to_s
      "spec: #{spec}\n" \
        "error: #{error}"
    end
  end
end
