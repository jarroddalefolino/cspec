# frozen_string_literal: true

RSpec.describe CSpec::DataType do
  describe 'convert' do
    it 'converts a string' do
      expect(CSpec::DataType.convert('1').class).to eq(Integer)
    end

    it 'converts a float' do
      expect(CSpec::DataType.convert('1.0').class).to eq(Float)
    end

    it 'converts a string' do
      expect(CSpec::DataType.convert('hello').class).to eq(String)
    end

    it 'converts a blank string to a nil' do
      expect(CSpec::DataType.convert('').class).to eq(NilClass)
    end

    it 'converts a nil string to a nil' do
      expect(CSpec::DataType.convert('nil').class).to eq(NilClass)
    end

    it 'converts an array of stings' do
      result = CSpec::DataType.convert('["a", "b"]')
      expect(result.class).to eq(Array)
      expect(result).to eq(%w[a b])
    end
  end
end
