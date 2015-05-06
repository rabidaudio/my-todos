Parse = require('parse').Parse

module.exports = class Tasks extends Parse.Collection

  model: require '../models/Task'