class RoleGenerator
  def self.build_role(role)
    db_role = Role.new
    db_role.count = role[:player_count]
    db_role.save
    build_strategies(db_role, role[:strategy_count])
  end

  private

  def self.build_strategies(role, count)
    Array.new(count) do |i|
      s = Strategy.new
      s.role_id = role.id
      s.save
    end
  end
end