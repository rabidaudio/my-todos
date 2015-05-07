Parse = require('parse').Parse

Task = require './models/Task'

TemplateView = require './views/Template'
ListView = require './views/List'
NewListView = require './views/NewList'
ListsView = require './views/Lists'

Lists = require './collections/Lists'


module.exports = class Router extends Parse.Router

  routes:
    "": "tasks"
    "404": "not_found"
    ":request*": "not_found"

  not_found: (request) =>
    console.log request
    @renderTemplate require('./templates/404'), {request: request}

  tasks: =>
    lists = new Lists
    lists.fetch success: ->
      $('#app').append new NewListView(lists: lists).render().el
      $('#app').append new ListsView(collection: lists).render().el
      # lists.each (list) ->
      #   # This is a hack for relations. Instead of List owning a set of Tasks,
      #   # we query for the Tasks before render and attach them to the view. 
      #   # In a sense, a List is totally unaware of it's tasks.
      #   q = new Parse.Query Task
      #   q.equalTo 'parentList', list
      #   q.find success: (results) =>
      #     listView = new ListView model: list, tasks: new Tasks(results)
      #     $('#app').append listView.render().el


  # Helper method for rendering basic templates
  renderTemplate: (template, data) =>
    $('#app').html new TemplateView(template: template, data: data).render().el