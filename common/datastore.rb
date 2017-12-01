class Datastore

    attr_accessor :client, :host, :port, :credentials, :collection

    def initialize(host=nil, port=nil, auth=nil, collection=nil)

	    if host.nil? 
		    @host = '127.0.0.1' #Local host is default.
	    else
		    @host = host
	    end 
			
			auth = {}

    end

    #You can pass in configuration file and load details from that.
    def config=(config_file)
        @config = config_file
        get_system_config(@config)
    end


    #Load in the configuration file details, setting many object attributes.
    def get_system_config(config)

        config = YAML.load_file(config_file)

        #Config details.
        @host = config['database']['host']
        @port = config['database']['port']

        #Credentials managed by subclass?
        @credentials = config['datastore']['credentials']

        @collection = config['datastore']['collection']
    end


    def to_s
        "Datastore object => " + @host + ":" + @port.to_s + "@" + @credentials['username'] + " schema:" + @collection
    end
    
    #Fundamental design question: Connect to data store when creating object, a singleton that persists the connection
    # until the calling app exits.  OR -- other extreme, do we open/close per Tweet? Don't think so. With Search we
    # should at least open/close per request, and batch REPLACE up to 500 Tweets.

    def connect
       @client = nil
			 #Make connection to database.
    end

    def disconnect
        @client.close
    end
	
	  def storeTweet(tweet)
			
			#Write Tweet to data store.
			
	  end

end #Datastore class.