Dir[File.dirname(__FILE__) + '/methods/*.rb'].each do |file|
  require file
end