require "pry"
require "require_all"
require_all "lib/models", "lib/utilities/", "lib/config"


$logger.warn "ENTRYPOINT"
#TODO: Remove before release

app = UEApp.new("b56063451547432d99111c91fd5d968b", "695590bcf875546bf85c6358d3512ef8" )

options = {
    receivers:[
        {
            name:"me"
        },
        {
            name:"Page",
            id:"122"
        }
    ],
    message:{
        subject:"test",
        body: "ABC",
        image:"http://politibits.blogs.tuscaloosanews.com/files/2010/07/sanford_big_dummy_navy_shirt.jpg",
        link:{
            uri: "http://google.com",
            description: "link desc",
            title:"link title"
        }
    }
}
binding.pry
puts "X"

