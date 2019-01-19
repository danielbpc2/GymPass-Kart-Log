require 'rspec'
require_relative '../lib/utils/helpers'

describe '#time_in_ms' do
  it 'takes time displayed like : Min:Seg.Ms and turns into ms' do
    expect(time_in_ms('1:30.100')).to eql(((1 * 60) * 1000 ) + (30 * 1000) + 100)
  end

  it 'Should return an integer' do
    expect(time_in_ms('1:30.100')).to be_a Integer
  end
end

describe '#ms_to_min' do
  it 'Turns a amount of ms into minutes' do
    expect(ms_to_min(60000)).to eql(1.0)
  end

  it 'Should return a float' do
    expect(ms_to_min(60000)).to be_a Float
  end
end

  describe '#get_avg' do
    it 'Simply makes an average of an array' do
      expect(get_avg([7,7,7])).to eql((7+7+7)/3)
    end
  end
