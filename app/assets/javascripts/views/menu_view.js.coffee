class Awesomeness.Views.MenuView extends Backbone.View
  el: '#menu-box'

  initialize: () ->
    @initTemplate()

  initTemplate: () ->
    source = $('#menu-template').html()
    @template = Handlebars.compile(source)

  render: ->
    html = @template({})
    @$el.html(html)

  clear: ->
    @$el.html('')