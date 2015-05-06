Parse = require('parse').Parse
$ = window.jQuery
Parse.$ = $

window.Parse = Parse

Router = require './router'

$(document).ready ->

  Parse.initialize "Maz454l3qY1v4SeJq6feaPfB5uH8Gwjw2rooOZpY", "yAT1hGSg9jiNQiJXjc4R4rVmtBWUd59jG0F3S3oH"

  router = new Router

  router.navigate('404', {trigger: true, replace: false}) unless Parse.history.start({pushState: false})