require File.expand_path('../../lib/factual', __FILE__)

begin
  f = Factual.new("KEY", "SECRET")
  f.get("/places")
rescue StandardError => e
  puts e.message.include?('"error_type":"Auth"').inspect
end
