class AbstractGambit
  include AbstractMethod

  def initialize(file_name)
    @file_name = file_name
    @cached = false
  end

  def time_cached
    DB.disconnect
    system('echo $EXEC | sudo -u postgres /usr/local/pgsql/bin/pg_ctl stop -D /usr/local/pgsql/data')
    ensure_cached
    responses = execute.split("\n")
    system('echo $EXEC | sudo -u postgres /usr/local/pgsql/bin/pg_ctl start -D /usr/local/pgsql/data -o "--config-file=/home/bcassell/DDGT/db_configs/maxing_out.conf"')
    sleep 1
    responses[responses.length - 2].to_f
  end

  def time_uncached
    DB.disconnect
    system('echo $EXEC | sudo -u postgres /usr/local/pgsql/bin/pg_ctl stop -D /usr/local/pgsql/data')
    uncache
    responses = execute.split("\n")
    system('echo $EXEC | sudo -u postgres /usr/local/pgsql/bin/pg_ctl start -D /usr/local/pgsql/data -o "--config-file=/home/bcassell/DDGT/db_configs/maxing_out.conf"')
    sleep 1
    responses.last.to_f
  end

  def uncache
    @cached = false
    system('echo $EXEC | sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"')
  end
end
