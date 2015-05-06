Parse = require('parse').Parse

TaskView = require './Task'

module.exports = class TasksView extends Parse.View

  views: []

  initialize: =>
    @collection.each (task) =>
      @views.push new TaskView model: task


  render: =>
    @$el.html('<ul class="tasks"></ul>')
    ul = @$el.find '.tasks'
    @views.forEach (view) =>
      ul.append view.render().el
    return @