Parse = require('parse').Parse

TemplateView = require './Template'

List = require '../models/List'

ENTER_KEY = 13

module.exports = class NewListView extends TemplateView

  template: require '../templates/NewList'

  className: 'new-list'

  events:
    'keypress .name': 'addOnEnter',
    'keypress .notes': 'addOnEnter'

  initialize: (opts) =>
    super
    @lists = opts.lists

  addOnEnter: (e)=>
    if e.which is ENTER_KEY
      list = new List
        name: @$el.find('.name').val(),
        notes: @$el.find('.notes').val(),
        owner: Parse.User.current()
      # console.log list
      list.save null, success: =>
        @lists.add list
        @$el.find('.name').val('')
        @$el.find('.notes').val('')