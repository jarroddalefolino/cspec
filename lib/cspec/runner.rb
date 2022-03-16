# frozen_string_literal: true

require 'colorize'

module CSpec
  module Runner
    def self.run!(filepath)
      return false if process_errors(Loader.validate_structure(filepath))

      specs = Loader.load(filepath)
      return false if process_errors(::CSpec::Validator.validate_specs(specs))

      success = CSpec::Result.success?(results = run(specs))

      present_result(success, results)
    end

    def self.present_result(success, results)
      if success
        puts 'Success'.green
        true
      else
        puts 'Failure'.red
        puts ResultsOutputter.display(results).red
        false
      end
    end

    def self.run(specs)
      specs.map do |spec|
        result = ::CSpec::CodeExec.do(spec)
        expected = ::CSpec::DataType.convert(spec.expected)
        error_msg = "Expected #{spec.expected}, got: #{result}" if result != expected
        Result.from_spec(spec, error_msg)
      rescue StandardError => e
        Result.from_spec(spec, e.inspect)
      end
    end

    def self.process_errors(errors)
      puts errors unless errors.empty?
      !errors.empty?
    end
  end
end
