class UEUser

    #URI: user://e9759590-54ef-4cd3-a01c-cb2241ddd812:1aee1a25-e0c4-4036-a8fd-4d41adc8611b@
    #COMB: key,secret
    ## Constructor
    # @desc The constructor can be in one of two forms; URI form or key,secret form. eg new User(key,secret) or new User(uri)
    # @param {String} uri the user uri string
    # @param {String} key the user key
    # @param {String} secret the user secret
    def initialize(uri)
    end

    ###
    # Adds a connection to the current user
    #
    # @param {String} connection_name the connection identifier. Unique per connection
    # @param {String} service a string representing a connector service - supported services are in config/service_schemes.js
    # @param {String} service_access_token service access token acquired from the provider (fb token, twitter token..etc)
    #
    # @return {UEConnection} connection the created connection
    #/
    def add_connection(connection_name, service, service_access_token) 

    end

    ##
    # List connections for current user
    # @return {Connection>} List of Connection objects representing the user connections
    def list_connections() 
    end



    #
    # Removes a connection from a user
    #
    # @param {String} connection_name the connection identifier
    # @return {Boolean} Success/Fail
    #
    def remove_connection(connection_name) 
    end


    #
    # Tests a connection to a connector
    #
    # @param {String} serviceUri service uri. eg: facebook://accesstoken@facebook.com
    # @return {Boolean} Success/Fail
    #
    def test_connection(service_uri) 
    end



end
