Parse = require('parse').Parse

NewTaskView = require './NewTask'
TemplateView = require './Template'
TasksView = require './Tasks'

# Takes in both a @model (List) and a collection of Tasks (@tasks)
module.exports = class ListView extends TemplateView

  tagName: 'div'
  className: 'list'

  template: require '../templates/List'

  events:
    'click .delete' : 'trash'
    # TODO editable fields

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

  trash: =>
    if confirm "Are you sure you want to delete #{@model.get('name')} and all #{@tasks?.length || 0} of it's tasks?"
      @tasks.each (task) ->
        task.destroy()
      @model.destroy()