Dir[File.dirname(__FILE__) + '/experiments/*.rb'].each do |file|
  require file
end
