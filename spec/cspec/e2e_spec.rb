# frozen_string_literal: true

require_relative 'test_classes'

RSpec.describe CSpec::Runner do
  describe 'run!' do
    it 'processes all of the csv test cases (happy days)' do
      result = CSpec::Runner.run!("#{Dir.pwd}/spec/cspec/fixtures/e2e.csv")
      expect(result).to eq(true)
    end

    it 'processes all of the csv test cases (fail)' do
      result = CSpec::Runner.run!("#{Dir.pwd}/spec/cspec/fixtures/e2e_with_failure.csv")
      expect(result).to eq(false)
    end
  end
end
