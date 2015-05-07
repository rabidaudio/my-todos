Parse = require('parse').Parse

TemplateView = require './Template'

Task = require '../models/Task'

ENTER_KEY = 13

module.exports = class NewTaskView extends TemplateView

  template: require '../templates/NewTask'
  className: 'new-task'

  events:
    'keypress .edit': 'addOnEnter'

  initialize: (opts) =>
    super
    @tasks = opts.tasks
    @parentList = opts.parentList

  addOnEnter: (e) =>
    if e.which is ENTER_KEY
      task = new Task
        description: @$el.find('.edit').val(),
        completed: false
        parentList: @parentList
        priority: @tasks.length
      task.save null, success: =>
        @tasks.add task