# node-utils
utility libraries for node apps

## Components
* [Config](#config)
* [Mongo](#mongo)
* [Redis](#redis)
* [ENV](#env)
* [GulpHelper](#gulpHelper)


<h3 id="config">Config</h3>
Supports json and yaml configuration string/file:

````
{Config} = require 'node-utils'
config = Config.fromYAMLFile(__dirname+"/config.yaml")
host = config.get("db.host")
port = config.getOrDefault("db.port", 27017)

````

<h3 id="mongo">Mongo</h3>
Connect to mongo

````
{Mongo} = require 'node-utils'
mongo = Mongo.connect "localhost", 27017
db = mongo.db("myDB")
coll = db.collection "myColl"
coll.find({}).toArray (err, data) ->
  console.log data
````

<h3 id="redis">Redis</h3>
Initializes a redis client:

````
{Redis} = require 'node-utils'
redis = new Redis() # default localhost:6379
redis.client.set "key", "value", (err) ->
````

<h3 id="env">ENV</h3>
ENV is used to set process.env data from json/yaml

````
{ENV} = require 'node-utils'
ENV.fromJSON('{"mongo": {"host": "localhost"}}').load("MYAPP")
# process.env.MYAPP_MONGO_HOST is "localhost" now
````

<h3 id="gulpHelper">GulpHelper</h3>
Helps to auto-restart a service when files are changed in gulpfile:

````
gulp  = require 'gulp'
{gulpHelper} = require 'node-utils'
gulp.task 'dev', ->
  gulpHelper.devServer("coffee app.coffee", [__dirname+"/src"])

````