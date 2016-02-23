#Require all models
Gem.find_files("config/*.rb").each { |path| require path}
Gem.find_files("models/*.rb").each { |path| require path }
Gem.find_files("utilities/*.rb").each { |path| require path}

app = UEApp.new("x","y");

res = UERequest.fetch("user/list", {
    user:"2206779c2acc42e2824c62026001ac25",
    pass:"65c9ab904a3354738a4442e798f27387"
})


puts res
