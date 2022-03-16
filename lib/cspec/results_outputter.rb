# frozen_string_literal: true

module CSpec
  module ResultsOutputter
    def self.display(results)
      results.map(&:to_s).join("\n")
    end
  end
end
