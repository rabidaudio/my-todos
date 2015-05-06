Parse = require('parse').Parse

TaskView = require './Task'

module.exports = class TasksView extends Parse.View

  views: []

  tagName: 'ul'
  className: 'tasks'

  initialize: =>
    @collection.each (task) =>
      @views.push new TaskView model: task


  render: =>
    @views.forEach (view) =>
      @$el.append view.render().el
    return @