Parse = require('parse').Parse

###
  This is a simple view which takes in a template function
  (e.g. Handlebars), an optional data object, and an element
  to place it in. Data can be a simple Object @data or a
  Backbone.Model @model

  new TemplateView {el: '#app', template: require('./templates/MyTemplate'), data: {}}
###
module.exports = class TemplateView extends Parse.View

  tagName: 'div'


  initialize: (opts) =>
    @model.on('change', @render) if @model
    @template = @template || opts.template
    @data = opts.data

  render: =>
    # Backbone LocalStorage bug - https://github.com/tastejs/todomvc/issues/469
    # return if @model?.changed.id?
    @$el.html @template @model?.toJSON() or @data
    return @