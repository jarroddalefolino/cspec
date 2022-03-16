# frozen_string_literal: true

def example(error = nil)
  ::CSpec::Result.new(
    ::CSpec::Spec.new({ 'class' => 'Calculator', 'name' => 'test1',
                        'type' => 'instance', 'method_args' => [], 'initialization_args' => ['1'],
                        'initialization_arg_1' => '1', 'method' => 'add',
                        'method_arg_1' => '1', 'expected' => '2' }), error
  )
end

RSpec.describe CSpec::ResultsOutputter do
  describe 'display' do
    it 'displays nothing if no error' do
      result = CSpec::ResultsOutputter.display([example])
      expect(result).to eq('')
    end

    it 'displays the errors' do
      result = CSpec::ResultsOutputter.display([example('not correct')])
      expect(result).to eq('name: test1, class: Calculator, method: add, method_args: [], error: not correct')
    end
  end
end
