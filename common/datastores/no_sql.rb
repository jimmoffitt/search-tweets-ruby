class NoSQL

	attr_accessor :host,                 # Where datastore is hosted. local, internal, or on the cloud.
	              :port,                 # Common defaults: MySQL: 3306, MongoDB: ?, SQL Server 1433, PostgreSQL: 5432
	              :credentials,          # Flexible hash that holds datastore-specific creds for connection authentication.
	              # Most datastores have username and passwords, but should anticipate using keys and tokens.
	              :collection,           # For NoSQL datastores, this is the "collection" name. A Folder of Tweets.
	              :engine,
	              :connected            # Enables client app to confirm state.

	def initialized(host=nil, port=nil, credentials=nil, collection=nil)
		@connected = false
	end


	def storeTweet(tweet)
	end

	def disconnect
		#@engine.close or whatever the engine's disconnect command is.
		@engine = nil
		@connected = false
	end

	def connect
		#@engine = client.new()
		@connected = true # If error free.
		engine
	end
	
end
