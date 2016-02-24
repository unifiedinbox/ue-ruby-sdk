require "pry"
require "require_all"
require_all "lib/models", "lib/utilities/", "lib/config"


$logger.warn "ENTRYPOINT"
#TODO: Remove before release

app = UEApp.new("2206779c2acc42e2824c62026001ac25","65c9ab904a3354738a4442e798f27387")
puts app.list_users
# binding.pry
puts "X"
