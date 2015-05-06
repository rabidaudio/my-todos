Parse = require('parse').Parse

TemplateView = require './views/Template'
TasksView = require './views/Tasks'

Tasks = require './collections/Tasks'


module.exports = class Router extends Parse.Router

  routes:
    "": "tasks"
    "404": "not_found"
    ":request*": "not_found"

  not_found: (request) =>
    console.log request
    @renderTemplate require('./templates/404'), {request: request}

  tasks: =>

    tasks = new Tasks
    tasks.fetch success: (tasks) ->

      tasksView = new TasksView collection: tasks
      $('#app').html tasksView.render().el


  # Helper method for rendering basic templates
  renderTemplate: (template, data) =>
    $('#app').html new TemplateView(template: template, data: data).render().el