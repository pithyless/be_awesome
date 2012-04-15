class Awesomeness.Views.MeterView extends Backbone.View
  el: '#meter-box'

  initialize: () ->
    @initTemplate()

  initTemplate: () ->
    source = $('#meter-template').html()
    @template = Handlebars.compile(source)

  render: ->
    html = @template({})
    @$el.html(html)

  clear: ->
    @$el.html('')