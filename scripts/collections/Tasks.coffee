Parse = require('parse').Parse

module.exports = class Tasks extends Parse.Collection
  className: "Task"

  model: require '../models/Task'