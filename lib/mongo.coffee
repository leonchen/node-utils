mongo = require 'mongoskin'

class Mongo
  @connect: (host, port, db) ->
    if arguments.length == 2
      db   = port
      port = 27017

    m = new Mongo()
    m.host = host
    m.port = port
    m.dbName = db
    return m

  constructor: (@host, @port) ->
    @host ||= '127.0.0.1'
    @port ||= 27017
    @dbs    = {}

  db: (name=@dbName) ->
    path = "mongodb://#{@host}:#{@port}/#{name}"
    @dbs[name] ||= mongo.db(path, { native_parser: true, slaveOk: true })
    @dbs[name].setMaxListeners(1337)
    return @dbs[name]

  getDB: (coll, isDb) ->
    if isDb
      name = coll
    else
      name = @dbName

    return @db(name)

  toObjectID: mongo.helper.toObjectID

module.exports = Mongo
