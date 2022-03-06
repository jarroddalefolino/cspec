# frozen_string_literal: true

require_relative 'test_classes'

RSpec.describe CSpec::Runner do
  describe 'run' do
    it 'processes each result' do
      spec = ::CSpec::Spec.new(
        {
          'class' => 'Calculator',
          'name' => 'test1',
          'type' => 'instance',
          'initialization_args' => [1],
          'method' => 'add',
          'method_args' => [1],
          'expected' => 2
        }
      )
      result = CSpec::Runner.run([spec])
      expect(result.size).to eq(1)
      expect(result).to eq([CSpec::Result.new(spec, nil)])
    end
  end
end
