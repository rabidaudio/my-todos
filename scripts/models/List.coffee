Parse = require('parse').Parse

Task = require '../models/Task'

module.exports = class List extends Parse.Object
  className: "List"

  updateNotes: (text) => @set 'notes', text