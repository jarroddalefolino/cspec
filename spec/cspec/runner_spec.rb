# frozen_string_literal: true

RSpec.describe CSpec::Runner do
  before(:all) do
    class MyCalculator
      def initialize(starting_number)
        @starting_number = starting_number
      end

      def add(amount)
        @starting_number + amount
      end

      def add_more(amount, amount2)
        @starting_number + amount + amount2
      end
    end

    class CalculatorClass
      def self.subtract(x, y)
        x - y
      end
    end

    class StringHelper
      def self.letter_count(a)
        a.size
      end
    end
  end

  describe 'run' do
    it 'processes each result' do
      result = CSpec::Runner.run([
                                   {
                                     class: 'MyCalculator',
                                     name: 'test1',
                                     type: 'instance',
                                     initialize_params: [1],
                                     method: 'add',
                                     method_args: [1],
                                     expected: 2
                                   }
                                 ])
      expect(result.size).to eq(1)
      expect(result).to eq([CSpec::Result.new('test1', 'MyCalculator', 'add', nil, nil, nil)])
    end
  end
end
