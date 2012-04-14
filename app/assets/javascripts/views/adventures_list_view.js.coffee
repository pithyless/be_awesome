class Awesomeness.Views.AdventuresListView extends Backbone.View
  el: '#adventures-list-box'

  initialize: () ->
    @initTemplate()

  initTemplate: () ->
    source = $('#adventures-list-template').html()
    @template = Handlebars.compile(source)

    itemSource = $('#adventures-list-item-template').html()
    @itemTemplate = Handlebars.compile(itemSource)
    
  render: (data) ->
    itemsHtml = @renderItems(data)
    pageHtml = @renderPage(itemsHtml)
    @$el.html(pageHtml)
    @$el.find('ul').html(itemsHtml)

  renderItems: (data) ->
    html = ''
    _.each data, (element) =>
      html += @itemTemplate( element )
    return html

  renderPage: () ->
    html = @template({})

  clear: ->
    @$el.html('')