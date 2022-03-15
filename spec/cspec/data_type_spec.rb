# frozen_string_literal: true

RSpec.describe CSpec::DataType do
  describe 'convert' do
    it 'converts a string into an Integer' do
      expect(CSpec::DataType.convert('1').class).to eq(Integer)
    end

    it 'converts a string with whitespace into an Integer' do
      expect(CSpec::DataType.convert(' 1 ').class).to eq(Integer)
    end

    it 'converts a float' do
      expect(CSpec::DataType.convert('1.0').class).to eq(Float)
    end

    it 'converts a float with whitespace' do
      result = CSpec::DataType.convert(' 1.0 ')
      expect(result.class).to eq(Float)
      expect(result).to eq(1.0)
    end

    it 'converts a false string' do
      expect(CSpec::DataType.convert('false')).to eq(false)
    end

    it 'converts a true string' do
      expect(CSpec::DataType.convert('true')).to eq(true)
    end

    it 'converts a string' do
      expect(CSpec::DataType.convert('hello').class).to eq(String)
    end

    it 'strips trailing and leading whitespace' do
      result = CSpec::DataType.convert(' hello ')
      expect(result.class).to eq(String)
      expect(result).to eq('hello')
    end

    it 'converts a blank string to a nil' do
      expect(CSpec::DataType.convert('').class).to eq(NilClass)
    end

    it 'converts a nil string to a nil' do
      expect(CSpec::DataType.convert('nil').class).to eq(NilClass)
    end

    it 'converts a whitespace string to a nil' do
      expect(CSpec::DataType.convert('   ').class).to eq(NilClass)
    end

    it 'converts an array of stings' do
      result = CSpec::DataType.convert('["a", "b"]')
      expect(result.class).to eq(Array)
      expect(result).to eq(%w[a b])
    end

    it 'does not convert an integer' do
      expect(CSpec::DataType.convert(1).class).to eq(Integer)
    end
  end
end
