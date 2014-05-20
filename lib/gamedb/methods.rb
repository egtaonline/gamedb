require File.dirname(__FILE__) + '/methods/abstract_method'
require File.dirname(__FILE__) + '/methods/abstract_gambit'
require File.dirname(__FILE__) + '/methods/abstract_pg'

Dir[File.dirname(__FILE__) + '/methods/*.rb'].each do |file|
  require file
end
