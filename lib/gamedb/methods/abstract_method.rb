module AbstractMethod
  def time_uncached
    t = Time.now
    execute_uncached
    Time.now - t
  end
  
  def time_cached
    t = Time.now
    execute_cached
    Time.now - t
  end
  
  def execute_uncached
    uncache
    execute
  end
  
  def execute_cached
    ensure_cached
    execute
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