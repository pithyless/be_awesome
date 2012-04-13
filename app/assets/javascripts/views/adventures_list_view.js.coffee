class Awesomeness.Views.AdventuresListView extends Backbone.View
  el: '#adventures-list-box'

  initialize: () ->
    @initTemplate()

  initTemplate: () ->
    source = $('#adventures-list-template').html()
    @template = Handlebars.compile(source)
    
  render: (data) ->
    html = ''
    _.each data, (element) =>
      html += @template( element )

    @$el.find('ul').html(html)

  clear: ->
    @$el.find('ul').html('')