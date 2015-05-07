Parse = require('parse').Parse

NewTaskView = require './NewTask'
TemplateView = require './Template'
Tasks = require '../collections/Tasks'
Task = require '../models/Task'
TasksView = require './Tasks'

module.exports = class ListView extends TemplateView

  tagName: 'div'
  className: 'list'

  template: require '../templates/List'

  initialize: =>
    q = new Parse.Query Task
    q.equalTo 'parentList', @model
    q.find success: (results) =>
      @tasks = new Tasks results
      @tasks.on 'add remove', @render
      @render()

  render: =>
    super
    tasksView = new TasksView collection: @tasks or new Tasks
    @$el.find('.tasks-container').html tasksView.render().el
    @$el.find('.tasks-container').append new NewTaskView(collection: @collection).render().el
    return @
  #   @$el.empty()
  #   @collection.each (task) =>
  #     view = new TaskView model: task
  #     @$el.append view.render().el
  #   @$el.append new NewTaskView(collection: @collection).render().el
  #   return @