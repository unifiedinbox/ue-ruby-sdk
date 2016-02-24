require "pry"
require "require_all"
require_all "lib/models", "lib/utilities/", "lib/config"


$logger.warn "ENTRYPOINT"
#TODO: Remove before release

app = UEApp.new("b56063451547432d99111c91fd5d968b", "695590bcf875546bf85c6358d3512ef8" )

binding.pry
puts "X"

