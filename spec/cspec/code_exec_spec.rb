# frozen_string_literal: true

require_relative 'test_classes'

def example_cspec
  ::CSpec::Spec.new({
                      'class' => 'Calculator',
                      'type' => 'instance',
                      'initialization_args' => [1],
                      'method' => 'add',
                      'method_args' => [1]
                    })
end

def example2
  ::CSpec::Spec.new({
                      'class' => 'StringHelper',
                      'type' => 'class',
                      'method' => 'letter_count',
                      'method_args' => ['hello']
                    })
end

def example3
  ::CSpec::Spec.new({
                      'class' => 'CalculatorClass',
                      'type' => 'class',
                      'method' => 'subtract',
                      'method_args' => [11, 5]
                    })
end

def example4
  ::CSpec::Spec.new({
                      'class' => 'Calculator',
                      'type' => 'instance',
                      'initialization_args' => [0],
                      'method' => 'add_more',
                      'method_args' => [1, 3]
                    })
end

RSpec.describe CSpec::CodeExec do
  describe 'do' do
    it 'calls an instance method' do
      result = CSpec::CodeExec.do(example_cspec)
      expect(result).to eq(2)
    end

    it 'calls a class method' do
      result = CSpec::CodeExec.do(
        ::CSpec::Spec.new({
                            'class' => 'CalculatorClass',
                            'type' => 'class',
                            'method' => 'subtract',
                            'method_args' => [11, 5]
                          })
      )
      expect(result).to eq(6)
    end
  end

  describe 'do_instance' do
    it 'one param' do
      result = CSpec::CodeExec.do_instance(
        ::CSpec::Spec.new({
                            'class' => 'Calculator',
                            'type' => 'instance',
                            'initialization_args' => [1],
                            'method' => 'add',
                            'method_args' => [1]
                          })
      )
      expect(result).to eq(2)
    end

    it 'two params' do
      result = CSpec::CodeExec.do_instance(example4)
      expect(result).to eq(4)
    end
  end

  describe 'do_class' do
    it 'executes a class method' do
      result = CSpec::CodeExec.do_class(example3)
      expect(result).to eq(6)
    end

    it 'runs blah' do
      result = CSpec::CodeExec.do_class(example2)
      expect(result).to eq(5)
    end
  end
end
