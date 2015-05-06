Parse = require('parse').Parse

TaskView = require './Task'

Task = require '../models/Task'

ENTER_KEY = 13

module.exports = class NewTaskView extends TaskView

  template: require '../templates/NewTask'

  className: 'new-task'

  events:
    'keypress .edit': 'addOnEnter'

  addOnEnter: (e)=>
    return unless e.which is ENTER_KEY
    task = new Task description: @$el.find('.edit').val(), completed: false
    task.save()
    @collection.add task