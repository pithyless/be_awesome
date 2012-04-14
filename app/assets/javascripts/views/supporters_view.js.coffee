class Awesomeness.Views.SupportersView extends Backbone.View
  el: '#supporters-box'

  initialize: () ->
    @initTemplate()

  initTemplate: () ->
    source = $('#supporters-template').html()
    @template = Handlebars.compile(source)

  render: (dataToRender) ->
    html = @template(dataToRender)
    @$el.html(html) 

  clear: ->
    @$el.html('')