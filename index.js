require("coffee-script/register")

module.exports = {
  config = require("./lib/config"),
  mongo = require("./lib/mongo"),
  redis = require("./lib/redis")
}
