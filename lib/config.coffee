fs = require 'fs'
yaml = require 'js-yaml'

class Config
  @fromJSONString: (json) ->
    doc = JSON.parse(json)
    return new Config(doc)

  @fromJSONFile: (jsonFile) ->
    data = fs.readFileSync(jsonFile)
    doc = main.fromJSONString(data)
    return new Config(doc)

  @fromYAMl: (yaml) ->
    doc = yaml.safeLoad yaml
    return new Config(doc)

  @fromYAMLFile: (yamlFile) ->
    yaml = fs.readFileSync yamlFile
    doc = yaml.safeLoad yaml
    return new Config(doc)

  constructor: (@doc)

  get: (key) ->
    path = key.split(".")
    val = @doc
    for p in path
      throw "no data for key #{p}" unless val[p]
      val = val[p]
    return val
        
  getOrDefault: (key, defVal) ->
    path = key.split(".")
    val = @doc
    for p in path
      return defVal unless val[p]
      val = val[p]
    return val
