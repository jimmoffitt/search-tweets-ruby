class Relational
	
	require "mysql2"


	attr_accessor :host,                 # Where datastore is hosted. local, internal, or on the cloud.
	              :port,                 # Common defaults: MySQL: 3306, MongoDB: ?, SQL Server 1433, PostgreSQL: 5432
	              :credentials,          # Flexible hash that holds datastore-specific creds for connection authentication.
	              # Most datastores have username and passwords, but should anticipate using keys and tokens.
	              :database,           # For relational databases, this is the *schema* or *database* name.
	              # For NoSQL datastores, this is the "collection" name. A Folder of Tweets.
	              :connected,            # Enables client app to confirm state.
	              :engine

	def initialized(host=nil, port=nil, credentials=nil, database=nil)
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
		@engine = Mysql2::Client.new(:host => @host, :port => @port, :username => @user_name, :database => @database )
		@connected = true # If error free.
		engine
	end
	
end
