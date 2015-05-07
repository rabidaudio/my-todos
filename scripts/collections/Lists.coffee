Parse = require('parse').Parse

module.exports = class Lists extends Parse.Collection
  className: "List"

  model: require '../models/List'