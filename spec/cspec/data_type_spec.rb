# frozen_string_literal: true

RSpec.describe CSpec::DataType do
  describe 'convert' do
    [
      { input: '1', expected: 1 },
      { input: '-1', expected: -1 },
      { input: '  1  ', expected: 1 },
      { input: '  1.0  ', expected: 1.0 },
      { input: '-1.901', expected: -1.901 },
      { input: '  1.901  ', expected: 1.901 },
      { input: '  false  ', expected: false },
      { input: 'false', expected: false },
      { input: '  true  ', expected: true },
      { input: 'true', expected: true },
      { input: 1, expected: 1 },
      { input: '["a", "b"]', expected: %w[a b] },
      { input: 'nil', expected: nil },
      { input: '', expected: nil },
      { input: '    ', expected: nil }
    ].each do |tc|
      it "converts a string into an #{tc[:expected].class}" do
        result = CSpec::DataType.convert(tc[:input])
        expect(result).to eq(tc[:expected])
      end
    end

    it 'converts a nil string to a nil' do
      expect(CSpec::DataType.convert('nil').class).to eq(NilClass)
    end

    it 'converts a whitespace string to a nil' do
      expect(CSpec::DataType.convert('   ').class).to eq(NilClass)
    end
  end
end
