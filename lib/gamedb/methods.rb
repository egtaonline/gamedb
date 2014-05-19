require File.dirname(__FILE__) + '/methods/abstract_method'

Dir[File.dirname(__FILE__) + '/methods/*.rb'].each do |file|
  require file
end
