Dir[File.dirname(__FILE__) + '/generators/*.rb'].each do |file|
  require file
end
