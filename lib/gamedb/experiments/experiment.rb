class Experiment
  def initialize(methods, profile_space, description)
    @methods = methods
    @description = description
    @role_count = profile_space.keys.size
    @strategies_per_role = profile_space.map do |k, v|
# TODO finish here, then include players per role
    end
    GameGenerator.build(profile_space)
  end
  
  def run_cached_trials(iterations)
    methods.each do |method|
      iterations.times do
        time = method.time_cached
# Create TRIAL entry here
      end
    end
  end
  
  def run_uncached_trial
    
  end
end