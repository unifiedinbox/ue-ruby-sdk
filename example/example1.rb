require 'ue-ruby-sdk'

app = UEApp.new("UE_APP_ID","UE_APP_SECRET")

options = {
    receivers:[
        {
            name:"Page",
            id:"283031198486599"
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


user = app.create_user
user.list_connections[0].send_message options #send message using the first connector

