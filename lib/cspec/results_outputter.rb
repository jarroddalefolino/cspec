# frozen_string_literal: true

module CSpec
  module ResultsOutputter
    def self.display(results)
      results.each do |r|
        puts r
      end
    end
  end
end
