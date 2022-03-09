# frozen_string_literal: true

RSpec.describe CSpec::Validator do
  describe 'validate_specs' do
    it 'returns an error if the class does not exist' do
      spec = ::CSpec::Spec.new(
        {
          'class' => 'DoesNotExist',
          'name' => 'test1',
          'type' => 'instance',
          'initialization_args' => [1],
          'method' => 'add',
          'method_args' => [1],
          'expected' => 2
        }
      )
      expect(CSpec::Validator.validate_specs([spec])).to eq(['DoesNotExist does not exist'])
    end

    it 'returns no error if the class does  exist' do
      spec = ::CSpec::Spec.new(
        {
          'class' => 'Object',
          'name' => 'test1',
          'type' => 'instance',
          'initialization_args' => [1],
          'method' => 'add',
          'method_args' => [1],
          'expected' => 2
        }
      )
      expect(CSpec::Validator.validate_specs([spec])).to eq([])
    end
  end
end
