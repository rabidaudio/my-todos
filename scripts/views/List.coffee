Parse = require('parse').Parse

NewTaskView = require './NewTask'
TemplateView = require './Template'
Tasks = require '../collections/Tasks'
Task = require '../models/Task'
TasksView = require './Tasks'

# Takes in both a @model (List) and a collection of Tasks (@tasks)
module.exports = class ListView extends TemplateView

  tagName: 'div'
  className: 'list'

  template: require '../templates/List'

  initialize: (opts) =>
    super
    @tasks = opts.tasks
    @tasks.on 'add remove', @render

  render: =>
    super
    if @tasks?
      tasksView = new TasksView collection: @tasks
      @$el.find('.tasks-container').html tasksView.render().el
    @$el.find('.tasks-container').append new NewTaskView(tasks: @tasks, parentList: @model).render().el
    return @
  #   @$el.empty()
  #   @collection.each (task) =>
  #     view = new TaskView model: task
  #     @$el.append view.render().el
  #   @$el.append new NewTaskView(collection: @collection).render().el
  #   return @