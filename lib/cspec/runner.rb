# frozen_string_literal: true

module CSpec
  module Runner
    def self.run!(filepath)
      errors = Loader.validate(filepath)
      unless errors.empty?
        puts errors
        return false
      end
      specs = Loader.load(filepath)
      results = run(specs)

      return true if CSpec::Result.success?(results)

      ResultsOutputter.display(results)
      false
    end

    def self.run(specs)
      specs.map do |spec|
        result = ::CSpec::DataType.convert(::CSpec::Executer.do(spec))
        expected = ::CSpec::DataType.convert(spec[:expected])
        error_msg = "Expected #{spec[:expected]}, got: #{result}" if result != expected
        Result.from_spec(spec, error_msg)
      rescue StandardError => e
        Result.from_spec(spec, e.inspect)
      end
    end
  end
end
