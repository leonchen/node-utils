fs = require 'fs'
yaml = require 'js-yaml'

class Env
  @fromJSON: (json) ->
    new Env(JSON.parse(json))


  @fromYAMLFile: (yamlFile) ->
    yaml = fs.readFileSync yamlFile
    new Env(yaml.safeLoad yaml)

  constructor: (@data) ->

  load: (domain) ->
    prefix = if domain then domain else ""
    @setEnv(@data, prefix)

  setEnv: (obj, prefix) ->
    t = typeof(obj)
    if t == "object"
      for k, v of obj
        @setEnv(v, prefix+"_"+k.toUpperCase())
    else if t == "number" or t == "boolean"
      process.env[prefix] = obj.toString()
    else if t ==  "string"
      process.env[prefix] = obj


module.exports = Env
