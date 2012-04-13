class Awesomeness.Views.AdventureView extends Backbone.View
  el: '#adventure-box'

  initialize: () ->
    @initTemplate()

  initTemplate: () ->
    source = $('#adventure-template').html()
    @template = Handlebars.compile(source)
    
  render: (data) ->
    html = @template(data)
    @$el.html(html)

  clear: ->
    @$el.html('')