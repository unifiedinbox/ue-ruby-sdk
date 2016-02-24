require "json"
require "rest-client"
require "facets"

class UERequest
    def self.fetch(resource, request_options)
        form = request_options[:form] || {}
        user = request_options[:user]
        pass = request_options[:pass]

        $logger.debug form.inspect
        #Inject user:pass into base url
        url_prefix = Constants.base_url.gsub /https?:\/\//, "https://#{user}:#{pass}@"
        #Concat base url with resource
        url = url_prefix + resource
        $logger.debug "http => #{url}"

        response = RestClient.post url, form.to_json
        JSON.parse(response).symbolize_keys rescue response
    end
end
