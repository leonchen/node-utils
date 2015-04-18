redis = require 'redis'

HOST = "127.0.0.1"
PORT = 6379

class Redis
  constructor: (host, port, options={}) ->
    host ?= HOST
    port ?= PORT
    @client = redis.createClient(port, host, options)

module.exports = Redis
