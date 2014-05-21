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
    DB.disconnect
    system('echo $EXEC | sudo -u postgres /usr/local/pgsql/bin/pg_ctl stop -D /usr/local/pgsql/data')
    sleep 1
    system('echo $EXEC | sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"')
    sleep 1
    system('echo $EXEC | sudo -u postgres /usr/local/pgsql/bin/pg_ctl start -D /usr/local/pgsql/data -o "--config-file=/home/bcassell/DDGT/db_configs/maxing_out.conf"')
    sleep 1
  end

  def to_s
    self.class.to_s
  end
end
