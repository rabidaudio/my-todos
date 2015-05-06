Parse = require('parse').Parse

TemplateView = require './views/Template'

module.exports = class Router extends Parse.Router

  routes:
    "": "home"
    "404": "not_found"

  not_found: => new TemplateView el: '#app', template: require('./templates/404')

  home: =>
    console.log "yay!"