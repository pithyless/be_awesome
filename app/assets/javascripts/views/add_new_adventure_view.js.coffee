class Awesomeness.Views.NewAdventureView extends Backbone.View
  el: '#new-adventure-box'

  initialize: () ->
    @initTemplate()

  initTemplate: () ->
    source = $('#new-adventure-template').html()
    @template = Handlebars.compile(source)

  render: ->
    html = @template({})
    @$el.html(html)

  clear: ->
    @$el.html('')