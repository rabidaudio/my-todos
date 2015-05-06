Parse = require('parse').Parse

TaskView = require './Task'

module.exports = class NewTaskView extends TaskView

  template: require '../templates/NewTask'

  className: 'new-task'

  events: {}

