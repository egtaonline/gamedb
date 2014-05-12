class StockGambit
  include AbstractMethod

  def initialize(file_name)
    @file_name = file_name
    @cached = false
  end

  def execute
    system("gambit-enumpure < #{@file_name} > stock_gambit_#{Time.now}.out")
  end

  def ensure_cached
    unless @cached
      system("gambit-enumpure < #{@file_name}")
      @cached = true
    end
  end

  def uncache
    @cached = false
    super
  end
end
