# Singleton class that provides a 'datastore' object that knows how to store data.
 	

# Client usage:    require_relative './common/datastore.rb'
#                  datastore = Datastore.new(config)
#                 
#                  datastore.connect
#                  #Iterate through Tweets
#                       datastore.storeTweet(tweet.json)
#                  datastore.disconnect


require_relative '/datastores/relational.rb'
require_relative '/datastores/nosql.rb'

class Datastore

    attr_accessor :host,                 # Where datastore is hosted. local, internal, or on the cloud.
	          :port,                 # Common defaults: MySQL: 3306, MongoDB: ?, SQL Server 1433, PostgreSQL: 5432
	          :credentials,          # Flexible hash that holds datastore-specific creds for connection authentication.
	                                 # Most datastores have username and passwords, but should anticipate using keys and tokens.
	          :collection,           # For relational databases, this is the *schema* or *database* name. Separate "collections" 
	                                 # will need Tweet level *project name* tags. 
	                                 # For NoSQL datastores, this is the "collection" name. A Folder of Tweets. 
	          :connected,            # Enables client app to confirm state.
	         
	          :type,                 # Types: 'relational', 'nosql' 
	          :client                # datastore 'engine'. One usage is to indicate a collection name and store type: 'dev-mysql'
	 

    def initialize(host=nil, port=nil, auth=nil, collection=nil)

	    if host.nil? 
		@host = 'localhost' # or '127.0.0.1' #Local host is default.
	    else
		@host = host
	    end 
	
	    @auth = {}
	    if !auth.nil? 
               @auth = auth		    
	    end

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
        "Datastore object => " + @host + ":" + @port.to_s + "@" + @credentials['user_name'] + " schema:" + @collection
    end
    
    #Fundamental design question: Connect to data store when creating object, a singleton that persists the connection
    # until the calling app exits.  OR -- other extreme, do we open/close per Tweet? Don't think so. With Search we
    # should at least open/close per request, and batch REPLACE up to 500 Tweets.

    #Make connection to database. 	
    def connect
       #Connect to datastore, requires authentication, and returns this singleton object. 
       #
       @connected = true	    
       	    
       
    end

    def disconnect
        @client.close
        @connected = true	
    end

    def storeTweet(tweet)
	#Write Tweet to data store.
    end

end #Datastore class.
