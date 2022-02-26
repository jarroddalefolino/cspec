# frozen_string_literal: true

RSpec.describe CSpec::Executer do
  before(:all) do
    class Calculator
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

  describe 'do_instance' do
    it 'one param' do
      result = CSpec::Executer.do_instance({
                                             class: 'Calculator',
                                             type: 'instance',
                                             initialize_params: [1],
                                             method: 'add',
                                             method_args: [1]
                                           })
      expect(result).to eq(2)
    end

    it 'two params' do
      result = CSpec::Executer.do_instance({
                                             class: 'Calculator',
                                             type: 'instance',
                                             initialize_params: [0],
                                             method: 'add_more',
                                             method_args: [1, 3]
                                           })
      expect(result).to eq(4)
    end
  end

  describe 'do_class' do
    it 'runs blah' do
      result = CSpec::Executer.do_class({
                                          class: 'CalculatorClass',
                                          type: 'class',
                                          method: 'subtract',
                                          method_args: [11, 5]
                                        })
      expect(result).to eq(6)
    end

    it 'runs blah' do
      result = CSpec::Executer.do_class({
                                          class: 'StringHelper',
                                          type: 'class',
                                          method: 'letter_count',
                                          method_args: ['hello']
                                        })
      expect(result).to eq(5)
    end
  end
end
