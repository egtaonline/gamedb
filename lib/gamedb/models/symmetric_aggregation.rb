class SymmetricAggregation < Sequel::Model(:symmetric_aggs)
  def self.reseed_payoffs
    DB.run "UPDATE symmetric_aggs SET payoff = random()"
  end
end
