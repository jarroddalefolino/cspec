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
      results = []
      specs.each do |spec|
        result = ::CSpec::DataType.convert(::CSpec::Executer.do(spec))
        expected = ::CSpec::DataType.convert(spec[:expected])
        error_msg = "Expected #{spec[:expected]}, got: #{result}" if result != expected
        results << Result.from_spec(spec, error_msg)

      rescue StandardError => e
        results << Result.new(spec[:name], spec[:class], spec[:method],
                              e.inspect, spec[:description], nil)
      end
      results
    end
  end
end
