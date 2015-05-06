Parse = require('parse').Parse
$ = window.jQuery
Parse.$ = $

window.Parse = Parse #TODO remove

Router = require './router'

$(document).ready ->

  Parse.initialize "Maz454l3qY1v4SeJq6feaPfB5uH8Gwjw2rooOZpY", "yAT1hGSg9jiNQiJXjc4R4rVmtBWUd59jG0F3S3oH"

  router = new Router

  Parse.history.start({pushState: false})