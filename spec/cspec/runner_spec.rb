# frozen_string_literal: true

require_relative 'test_classes'

RSpec.describe CSpec::Runner do
  describe 'run' do
    it 'processes each result' do
      result = CSpec::Runner.run([
                                   {
                                     'class' => 'MyCalculator',
                                     'name' => 'test1',
                                     'type' => 'instance',
                                     'initialize_params' => [1],
                                     'method' => 'add',
                                     'method_args' => [1],
                                     'expected' => 2
                                   }
                                 ])
      expect(result.size).to eq(1)
      expect(result).to eq([CSpec::Result.new('test1', 'MyCalculator', 'add', nil, nil, nil)])
    end
  end
end
