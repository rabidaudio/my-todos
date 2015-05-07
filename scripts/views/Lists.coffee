Parse = require('parse').Parse

ListView = require './List'
Task = require '../models/Task'
Tasks = require '../collections/Tasks'

module.exports = class ListsView extends Parse.View

  tagName: 'ul'
  className: 'lists'

  initialize: =>
    @collection.on 'add', @buildListView
    @collection.on 'remove', @render #TODO

  render: =>
    @$el.empty()
    @collection.each (list) =>
      @buildListView list
    return @

  buildListView: (list) =>
    # This is a hack for relations. Instead of List owning a set of Tasks,
    # we query for the Tasks before render and attach them to the view. 
    # In a sense, a List is totally unaware of it's tasks.
    q = new Parse.Query Task
    q.equalTo 'parentList', list
    q.find success: (results) =>
      listView = new ListView model: list, tasks: new Tasks(results)
      @$el.append listView.render().el    
    