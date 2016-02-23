class UEApp

    ##
    # Constructor
    # @param {String} app_key
    # @param {String} app_secret
    def initialize(api_key, api_secret)
        @api_key = api_key
        @api_secret = api_secret
    end



    ##
    # Creates a UE User
    #
    # @return {UEUser} user the created user
    #
    def createUser() 
    end

    ##
    # Deletes a UE User
    #
    # @param {UEUser} user the user to delete
    # @return {Boolean} success/fail
    #
    def deleteUser( user ) 
    end

    ##
    # Returns a list of users for the current app
    #
    # @return {UEUser} users array of users on the app
    #
    def listUsers() 
    end

end
