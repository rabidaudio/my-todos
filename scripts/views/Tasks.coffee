Parse = require('parse').Parse

TaskView = require './Task'

module.exports = class TasksView extends Parse.View

  views: []

  initialize: =>
    @collection.each (task) =>
      @views.push new TaskView model: task, el: @$el


  render: =>
    @$el.empty()
    @views.forEach (view) =>
      @$el.append view.render().el
    return @