Parse = require('parse').Parse

TemplateView = require './views/Template'
TasksView = require './views/Tasks'

Tasks = require './collections/Tasks'


module.exports = class Router extends Parse.Router

  routes:
    "": "tasks"
    "404": "not_found"

  not_found: => new TemplateView(el: '#app', template: require('./templates/404')).render()

  home: =>
    console.log "yay!"

  tasks: =>

    tasks = new Tasks
    tasks.fetch success: (tasks) ->

      tasksView = new TasksView collection: tasks, el: $('<ul class="tasks"></ul>').appendTo '#app'
      tasksView.render()