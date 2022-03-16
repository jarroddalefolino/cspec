# frozen_string_literal: true

module CSpec
  module ResultsOutputter
    def self.display(results)
      results.reject { |r| r.error.nil? }.map(&:to_s).join("\n")
    end
  end
end
