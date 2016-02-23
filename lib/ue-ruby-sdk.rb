require "require_all"
require_all "lib"

app = UEApp.new("x","y");

res = UERequest.fetch("user/list", {
    user:"2206779c2acc42e2824c62026001ac25",
    pass:"65c9ab904a3354738a4442e798f27387"
})


puts res
