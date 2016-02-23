require "json"
require "rest-client"
require "facets"

class UERequest

    def self.fetch(url, request_options)

        puts request_options
        form = request_options[:form] || {}
        user = request_options[:user]
        pass = request_options[:pass]

        #Inject user:pass into url
        url = url.gsub /https?:\/\//, "https://#{user}:#{pass}@"

        response = RestClient.post url, form.to_json
        JSON.parse(response).symbolize_keys
    end

end
