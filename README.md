# ue-ruby-sdk 
> A UnificationEngine client SDK for Ruby/Rails

## Installation

```sh
$ gem install ue-ruby-sdk
```

## Usage

```ruby
app = UEApp.new("APP_KEY","APP_SECRET");
```

#### Creating User
```ruby
user = app.create_user
#user is an instance of UEUser
```

#### Listing Users
```ruby
users = app.list_users
#users is an array of User objects
```

#### Deleting User
```ruby
user = app.create_user
app.delete_user(user) #true
```

#### Adding a connection to a user
```ruby
connection = user.add_connection "myconnectionname", "facebook", "facebook_access_token"
#connection is an instance of UEConnection
```

- `connection_name` must be unique per connection.
- `access_token` has to be valid and working from the provider side


#### Listing User connections
```ruby
connections = user.list_connections
# connections is an array of UEConnection objects
```
#### Removing a User Connection
```ruby
user.remove_connection(connection_name) #true | false
```

#### Testing a connection
```ruby
#return true if working, false otherwise
user.test_connection(service_url) #eg: facebook://accesstoken@facebook.com
```

### Sending a message using a connection
```ruby
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

#uris will hold the uris for the sent messages
uris = user.list_connections[0].send_message options 
```
