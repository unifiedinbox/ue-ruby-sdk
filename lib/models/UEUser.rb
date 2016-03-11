require "facets"
class UEUser

    #URI: user://e9759590-54ef-4cd3-a01c-cb2241ddd812:1aee1a25-e0c4-4036-a8fd-4d41adc8611b@
    #COMB: key,secret
    ## Constructor
    # @desc The constructor can be in one of two forms; URI form or key,secret form. eg new User(key,secret) or new User(uri)
    # @param {String} uri the user uri string
    # @param {String} key the user key
    # @param {String} secret the user secret
    def initialize(uri_or_key, secret=nil)
        if secret then
            # key,secret format
            @user_key, @user_secret =  [uri_or_key, secret]
            @uri = "user://#{@user_key}:#{@user_secret}@"
        else
            # uri format
            @uri = uri_or_key
            @user_key, @user_secret =  uri_or_key.match(/user:\/\/(.+):(.+)@/).captures
        end
    end


    #Getters
    def uri
        @uri
    end

    def user_key
        @user_key
    end

    def user_secret
        @user_secret
    end

    ###
    # Adds a connection to the current user
    #
    # @param {String} connection_name the connection identifier. Unique per connection
    # @param {String} service_scheme a string representing a connector service (service scheme)
    # @param {String} service_access_token service access token acquired from the provider (fb token, twitter token..etc)
    #
    # @return {UEConnection} connection the created connection
    #/
    def add_connection(connection_name, service_scheme, service_access_token) 
        uri = "#{service_scheme}://#{service_access_token}@#{service_scheme}.com"
        response = UERequest.fetch "connection/add",{
            user: @user_key,
            pass: @user_secret,
            form: {
                uri: uri,
                name: connection_name
            }
        }

        puts response
        connection = UEConnection.new connection_name, uri, self
        (response[:status]==200)? connection : response


    end

    ##
    # List connections for current user
    # @return {Connection>} List of Connection objects representing the user connections
    def list_connections() 

        response = UERequest.fetch "connection/list",{
            user: @user_key,
            pass: @user_secret,
        }

        if  !response[:connections]
            return []
        end

        connections = []
        response[:connections].each do |cname,v| 
           connections.push(UEConnection.new cname, response[:connections][cname.to_sym][:uri], self)
        end
        connections 

    end



    #
    # Removes a connection from a user
    #
    # @param {String} connection_name the connection identifier
    # @return {Boolean} Success/Fail
    #
    def remove_connection(connection_name) 
        response = UERequest.fetch "connection/remove",{
            user: @user_key,
            pass: @user_secret,
            form:{
                name: connection_name
            }
        }

        response[:status] == 200


    end


    #
    # Tests a connection to a connector
    #
    # @param {String} serviceUri service uri. eg: facebook://accesstoken@facebook.com
    # @return {Boolean} Success/Fail
    #
    def test_connection(service_uri) 
        response = UERequest.fetch "connection/test",{
            user: @user_key,
            pass: @user_secret,
            form:{
                uri: service_uri
            }
        }

        response[:Status][:""][:status] == 200 



    end



end
