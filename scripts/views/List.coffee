Parse = require('parse').Parse
RenderMarkdown = require 'marked'

NewTaskView = require './NewTask'
TemplateView = require './Template'
TasksView = require './Tasks'

# Takes in both a @model (List) and a collection of Tasks (@tasks)
module.exports = class ListView extends TemplateView

  tagName: 'div'
  className: 'list'

  template: require '../templates/List'

  events:
    'click .delete'   : 'trash',
    'dblclick .notes' : 'changeNotes',
    'keypress .edit'  : 'updateOnEnter',
    'keydown .edit'   : 'revertOnEscape',
    'blur .edit'      : 'close'

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
    @$el.find('.notes').html RenderMarkdown @model.get 'notes'
    return @

  changeNotes: => @$el.addClass 'editing'

  close: =>
    @model.updateNotes @$el.find('.edit').val()
    @$el.removeClass 'editing'

  updateOnEnter: (e)=>
    @close() if e.which is ENTER_KEY

  revertOnEscape: (e)=>
    if e.which is ESC_KEY
      @$el.removeClass 'editing'
      @$el.find('.edit').val @model.get 'notes'


  trash: =>
    if confirm "Are you sure you want to delete #{@model.get('name')} and all #{@tasks?.length || 0} of it's tasks?"
      @tasks.each (task) ->
        task.destroy()
      @model.destroy()