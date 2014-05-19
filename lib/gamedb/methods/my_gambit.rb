class MyGambit < AbstractGambit
  def initialize(gambit_path, file_name)
    @gambit_path = gambit_path
    super(file_name)
  end

  def execute
    `#{@gambit_path} #{@file_name}`
  end

  def ensure_cached
    unless @cached
      system("gambit-enumpure #{@file_name}")
      @cached = true
    end
  end
end
