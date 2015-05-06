Parse = require('parse').Parse

module.exports = class Task extends Parse.Object
  className: "Task"

  complete: =>
    @set 'complete', true
    @save()

  save: =>
    super null #, (item) -> 