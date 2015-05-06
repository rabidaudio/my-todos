Parse = require('parse').Parse

TemplateView = require './Template'

module.exports = class TaskView extends TemplateView

  tagName: 'li'

  className: 'task'

  template: require '../templates/Task'