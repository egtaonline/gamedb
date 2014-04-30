class StrategyGenerator
  def self.build(role_id, strategy_names)
    value_string = strategy_names.map do |strategy|
      "(#{role_id}, '#{strategy}')"
    end.join(', ')
    DB.fetch('INSERT INTO strategies (role_id, strategy_name) VALUES ' \
             "#{value_string} RETURNING strategy_id, role_id, strategy_name")
      .all
  end
end
