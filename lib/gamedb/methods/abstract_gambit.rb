class AbstractGambit
  include AbstractMethod

  def initialize(file_name)
    @file_name = file_name
    @cached = false
  end

  def time_cached
    ensure_cached
    responses = execute.split("\n")
    responses[responses.length - 2].to_f
  end

  def time_uncached
    uncache
    responses = execute.split("\n")
    responses.last.to_f
  end

  def uncache
    @cached = false
    super
  end
end
