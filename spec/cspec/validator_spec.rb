# frozen_string_literal: true

def get_spec(overrides = {})
  {
    'class' => 'Object',
    'name' => 'test1',
    'type' => 'instance',
    'initialization_args' => [1],
    'method' => 'add',
    'method_args' => [1],
    'expected' => 2
  }.merge(overrides)
end

RSpec.describe CSpec::Validator do
  describe 'validate_specs' do
    it 'returns an error if the class does not exist' do
      spec = ::CSpec::Spec.new(get_spec({ 'class' => 'DoesNotExist' }))
      expect(CSpec::Validator.validate_specs([spec])).to eq(['DoesNotExist does not exist'])
    end

    it 'returns no error if the class exists and has defined instance method' do
      spec = ::CSpec::Spec.new(get_spec({ 'method' => '==' }))
      expect(CSpec::Validator.validate_specs([spec])).to eq([])
    end

    it 'returns an error if the class exists but does not have defined instance method' do
      spec = ::CSpec::Spec.new(get_spec({ 'method' => 'meow' }))
      expect(CSpec::Validator.validate_specs([spec])).to eq(['instance method: meow does not exist'])
    end

    it 'returns an error if the class exists but does not have defined class method' do
      spec = ::CSpec::Spec.new(
        get_spec({
                   'type' => 'class',
                   'method' => 'meow'
                 })
      )
      expect(CSpec::Validator.validate_specs([spec])).to eq(['class method: meow does not exist'])
    end
  end
end
