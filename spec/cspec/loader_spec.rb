# frozen_string_literal: true

RSpec.describe CSpec::Loader do
  describe 'process_args' do
    it 'merges all of the method args' do
      result = CSpec::Loader.process_args(
        {
          'class' => 'MyClass', 'name' => 'my test',
          'type' => 'instance', 'method' => 'greet',
          'method_arg_1' => 'Bob', 'expected' => 'Hello, Bob'
        }
      )
      expected = {
        'class' => 'MyClass', 'name' => 'my test',
        'type' => 'instance', 'method' => 'greet', 'method_arg_1' => 'Bob',
        'method_args' => ['Bob'], 'expected' => 'Hello, Bob',
        'initialization_args' => []
      }
      expect(result).to eq(expected)
    end
  end

  describe 'load' do
    it 'parses the csv into an array of hashes' do
      result = CSpec::Loader.load("#{Dir.pwd}/spec/cspec/fixtures/simple.csv")
      expected = { 'class' => 'MyCalculator', 'name' => 'test1',
                   'type' => 'instance',
                   'initialize_params_1' => '1', 'method' => 'add',
                   'method_args_1' => '1', 'expected' => '2' }
      expect(result.first).to eq(expected)
    end

    it 'validates the csv headers' do
      result = CSpec::Loader.validate("#{Dir.pwd}/spec/cspec/fixtures/simple.csv")
      expect(result).to eq([])
    end

    it 'validates the csv headers (missing class)' do
      result = CSpec::Loader.validate("#{Dir.pwd}/spec/cspec/fixtures/noclass.csv")
      expect(result).to eq(['Need header: class'])
    end

    it 'validates the csv headers (missing name)' do
      result = CSpec::Loader.validate("#{Dir.pwd}/spec/cspec/fixtures/noname.csv")
      expect(result).to eq(['Need header: name'])
    end

    it 'validates the csv headers (missing expected)' do
      result = CSpec::Loader.validate("#{Dir.pwd}/spec/cspec/fixtures/noexpected.csv")
      expect(result).to eq(['Need header: expected'])
    end

    it 'validates the csv headers (missing everything)' do
      result = CSpec::Loader.validate("#{Dir.pwd}/spec/cspec/fixtures/nothing.csv")
      expect(result).to eq(['Need header: class', 'Need header: type',
                            'Need header: name', 'Need header: method',
                            'Need header: expected'])
    end
  end
end
