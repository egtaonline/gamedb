# For now assume clean db in each step
class AbstractPg
  include AbstractMethod

  def initialize
    @cached = false
  end

  def execute
    system(query)
  end

  def ensure_cached
    unless @cached
      system(query)
      @cached = true
    end
  end

  def uncache
    @cached = false
    super
  end

  def query
    raise "Don't query abstract classes"
  end
end
