Parse = require('parse').Parse

module.exports = class Task extends Parse.Object
  className: "Task"

  toggle: =>
    @set 'completed', not @get('completed')
    console.log @toJSON()