module AbstractMethod
  def time_uncached
    uncache
    t = Time.now
    execute
    Time.now - t
  end

  def time_cached
    ensure_cached
    t = Time.now
    execute
    Time.now - t
  end

  # Does this break the testing apparatus?
  def uncache
    system('sync')
    system('echo 3 > /proc/sys/vm/drop_caches')
  end

  def to_s
    self.class.to_s
  end
end
