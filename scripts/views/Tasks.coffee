Parse = require('parse').Parse

TaskView = require './Task'
NewTaskView = require './NewTask'

module.exports = class TasksView extends Parse.View

  tagName: 'ul'
  className: 'tasks'

  views: []

  initialize: =>
    @collection.each (task) =>
      @views.push new TaskView model: task


  render: =>
    @views.forEach (view) =>
      @$el.append view.render().el
    @$el.append new NewTaskView().render().el
    return @