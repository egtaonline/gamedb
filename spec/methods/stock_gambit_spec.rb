require 'spec_helper'

class AbstractGambit
  def system(arg)
    unless arg == 'echo $EXEC | sudo -u postgres /usr/local/pgsql/bin/pg_ctl stop -D /usr/local/pgsql/data' || arg == 'echo $EXEC | sudo -u postgres /usr/local/pgsql/bin/pg_ctl start -D /usr/local/pgsql/data -o "--config-file=/home/bcassell/DDGT/db_configs/maxing_out.conf"'
      super
    end
  end
end

describe StockGambit do
  let(:prefix) { File.dirname(__FILE__) + "/../support/" }
  describe '#time_cached' do
    it 'returns a float number of seconds' do
      method = StockGambit.new(prefix + 'output.nfg')
      expect(method.time_cached.class).to be(Float)
    end
  end

  describe '#time_uncached' do
    it 'returns a float number of seconds' do
      method = StockGambit.new(prefix + 'output.nfg')
      expect(method.time_uncached.class).to be(Float)
    end
  end

  describe '#execute' do
    it 'returns the output of gambit' do
      method = StockGambit.new(prefix + 'output.nfg')
      responses = method.execute.split("\n")
      expect(responses.last.to_f > responses[responses.length-2].to_f)
        .to be true
    end
  end
end
