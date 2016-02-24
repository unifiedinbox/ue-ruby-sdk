require "uuidtools"
class UEConnection


    ##
    # @param {String}  connection_name the connection identifier
    # @param {String} connection_uri the connection uri
    # @param {User} User the User instance of the user owning the connection
    def initialize(connection_name, connection_uri, user)
        @name = connection_name
        @uri = connection_uri
        @user = user
    end

    def user
        @user
    end

    def refresh_connection() 
    end

    ##
    # Used for message parts
    # @access private
    # @returns {Number} random id
    #
    def self.generate_unique_id()
        UUIDTools::UUID.timestamp_create.to_s
    end


    ##
    # Builds the API message parameter from passed options
    #
    # @access private
    # @param {Object} message_options options for message
    # @param {Array} message_options.receivers channels receiving the message
    # @param {String} message_options.receivers.name channel name (Me | Page)
    # @param {String} message_options.receivers.id in case of Page, this is the page id
    # @param {String} message_options.message.subject message subject
    # @param {Array} message_options.message.body message body
    # @param {Array} message_options.message.image image uri
    # @param {Array} message_options.message.link message link
    # @param {Array} message_options.message.link.uri message link uri
    # @param {Array} message_options.message.link.description  message link description
    # @param {Array} message_options.message.link.title  message link title
    # @returns {Boolean}
    #
    def build_message_query(message_options)
        throw :RECEIVERS_AND_MESSAGE_REQUIRED if !message_options.key?(:receivers) || !message_options.key?(:message)


        default_content_type = "binary";
        params = message_options
        queryObject = {}

        #Formulate Receivers
        params[:receivers] = params[:receivers].map { |receiver|
            if receiver[:name ] && receiver[:name].downcase == "me" 
                {
                    name:"Me",
                    address:"test.test",
                    Connector: @name
                }
            elsif receiver[:name] && receiver[:name].downcase == "page"
                {
                    name:"Page",
                    address: receiver[:id],
                    Connector: @name
                }
            end
        }
        queryObject[:receivers] = params[:receivers];


        #Formulate Message Parts
        queryObject[:parts] = [];
        if params[:message].key?(:body)
            queryObject[:parts].push({
                id: UEConnection.generate_unique_id,
                contentType: default_content_type,
                type: "body",
                data: params[:message][:body],
            })
        end

        #Image Part
        if params[:message].key?(:image) 
            queryObject[:parts].push({
                id: UEConnection.generate_unique_id,
                contentType: default_content_type,
                type: "image_link",
                data: params[:message][:image]
            })
        end


        #Link Part
        if params[:message].key?(:link)
            if params[:message][:link][:uri]
                queryObject[:parts].push({
                    id: UEConnection.generate_unique_id,
                    contentType: default_content_type,
                    type: "link",
                    data: params[:message][:link][:uri]
                });
            end

            if params[:message][:link][:description]
                queryObject[:parts].push({

                    id: UEConnection.generate_unique_id,
                    contentType: default_content_type,
                    type: "link_description",
                    data: params[:message][:link][:description]
                })
            end

            if params[:message][:link][:title]
                queryObject[:parts].push({
                    id: UEConnection.generate_unique_id,
                    contentType: default_content_type,
                    type: "link_title",
                    data: params[:message][:link][:title]
                })
            end

        end

        #Subject
        if params[:message][:subject]
            queryObject[:subject ]= params[:message][:subject];
        end


        $logger.info(queryObject);
        return queryObject;


    end



    ##
    # Sends a message to service using a connector. A message can have multiple parts each with a different type.
    # eg: One can send a message with 2 parts (image_link, body) to send a message with an image and text
    #
    # @param {Object} message_options options for message
    # @param {Array} message_options.receivers channels receiving the message
    # @param {String} message_options.receivers.name channel name (Me | Page)
    # @param {String} message_options.receivers.id in case of Page, this is the page id
    # @param {String} message_options.message.subject message subject
    # @param {Array} message_options.message.body message body
    # @param {Array} message_options.message.image image uri
    # @param {Array} message_options.message.link message link
    # @param {Array} message_options.message.link.uri message link uri
    # @param {Array} message_options.message.link.description  message link description
    # @param {Array} message_options.message.link.title  message link title
    #
    # @returns {Promise}
    #
    def send_message(message_options)
        response = UERequest.fetch "message/send", {
            user: @user.user_key,
            pass: @user.user_secret,
            form:{
                message: self.build_message_query(message_options)
            } 
        }

        response[:URIs] rescue []

    end
end
