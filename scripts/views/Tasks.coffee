Parse = require('parse').Parse

TaskView = require './Task'

module.exports = class TasksView extends Parse.View

  tagName: 'ul'
  className: 'tasks'

  initialize: =>
    @collection.on 'add remove', @render

  render: =>
    @$el.empty()
    window.c = @collection
    @collection.sortBy((t)-> t.get 'priority' ).forEach (task) =>
      view = new TaskView model: task
      @$el.append view.render().el
    return @