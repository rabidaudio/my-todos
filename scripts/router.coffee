Parse = require('parse').Parse

TemplateView = require './views/Template'
TasksView = require './views/Tasks'
ListView = require './views/List'

Tasks = require './collections/Tasks'
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
      lists.each (list) ->
        listView = new ListView model: list
        # console.log listView
        $('#app').append listView.render().el


  # Helper method for rendering basic templates
  renderTemplate: (template, data) =>
    $('#app').html new TemplateView(template: template, data: data).render().el