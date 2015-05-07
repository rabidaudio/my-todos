Parse = require('parse').Parse

TaskView = require './Task'
NewTaskView = require './NewTask'

module.exports = class TasksView extends Parse.View

  tagName: 'ul'
  className: 'tasks'

  initialize: =>
    @collection.on 'add remove', @render

  render: =>
    @$el.empty()
    @collection.each (task) =>
      view = new TaskView model: task
      @$el.append view.render().el
    return @