class StockGambit < AbstractGambit
  def execute
    `gambit-enumpure < #{@file_name}`
  end

  def ensure_cached
    unless @cached
      system("gambit-enumpure < #{@file_name}")
      @cached = true
    end
  end
end
