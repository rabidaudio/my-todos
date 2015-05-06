Parse = require('parse').Parse

TemplateView = require './Template'

ENTER_KEY = 13
ESC_KEY = 27

module.exports = class TaskView extends TemplateView

  tagName: 'li'

  className: 'task'

  template: require '../templates/Task'

  events: {
    'click .checkbox': 'toggleCompleted',
    'dblclick .description': 'changeDescription',
    'keypress .edit': 'updateOnEnter',
    'keydown .edit': 'revertOnEscape',
    'blur .edit': 'close'
  }

  render: =>
    super
    @$el.find('.checkbox').prop 'checked', @model?.get 'completed'
    return @

  toggleCompleted: => @model.toggle()

  changeDescription: =>
    @$el.addClass 'editing'

  close: =>
    @model.set 'description', @$el.find('.edit').val()
    @$el.removeClass 'editing'

  updateOnEnter: (e)=>
    @close() if e.which is ENTER_KEY

  revertOnEscape: (e)=>
    return unless e.which is ESC_KEY
    @$el.removeClass 'editing'
    @$el.find('.edit').val @model.get 'description'