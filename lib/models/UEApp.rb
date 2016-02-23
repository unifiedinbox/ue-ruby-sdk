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
    def create_user() 
        UERequest.fetch "user/create", {
            user: @api_key,
            pass: @api_secret
        } 
    end

    ##
    # Deletes a UE User
    #
    # @param {UEUser} user the user to delete
    # @return {Boolean} success/fail
    #
    def delete_user( user ) 
        UERequest.fetch "user/delete", {
            user: @api_key,
            pass: @api_secret,
            form: {
                uri: user.uri
            }
        }
    end

    ##
    # Returns a list of users for the current app
    #
    # @return {UEUser} users array of users on the app
    #
    def list_users() 
        UERequest.fetch "user/list", {
            user: @api_key,
            pass: @api_secret
        }
    end

end
