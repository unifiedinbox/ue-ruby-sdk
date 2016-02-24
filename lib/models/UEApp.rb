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
        response = UERequest.fetch "user/create", {
            user: @api_key,
            pass: @api_secret
        } 
        response[:uri] ? UEUser.new(response[:uri]) : nil
    end

    ##
    # Deletes a UE User
    #
    # @param {UEUser} user the user to delete
    # @return {Boolean} success/fail
    #
    def delete_user( user ) 
        response = UERequest.fetch "user/delete", {
            user: @api_key,
            pass: @api_secret,
            form: {
                uri: user.uri
            }
        }
        response[:status] == 200? true: false
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
