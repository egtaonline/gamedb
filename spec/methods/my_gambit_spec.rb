require 'spec_helper'

describe MyGambit do
  let(:prefix) { File.dirname(__FILE__) + "/../support/" }
  describe '#time_cached' do
    it 'returns a float number of seconds' do
      method = MyGambit.new(prefix + 'gambit-enumpure', prefix + 'output.nfg')
      expect(method.time_cached.class).to be(Float)
    end
  end

  describe '#time_uncached' do
    it 'returns a float number of seconds' do
      method = MyGambit.new(prefix + 'gambit-enumpure', prefix + 'output.nfg')
      expect(method.time_uncached.class).to be(Float)
    end
  end

  describe '#execute' do
    it 'returns the output of gambit' do
      method = MyGambit.new(prefix + 'gambit-enumpure', prefix + 'output.nfg')
      responses = method.execute.split("\n")
      puts responses.inspect
      expect(responses.last.to_f > responses[responses.length-2].to_f)
        .to be true
    end
  end
end
