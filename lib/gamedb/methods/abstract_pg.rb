# For now assume clean db in each step
class AbstractPg
  include AbstractMethod

  def initialize
  end

  def execute
    system(query)
  end

  def ensure_cached
    system(query)
  end

  def query
    raise "Don't query abstract classes"
  end
end
