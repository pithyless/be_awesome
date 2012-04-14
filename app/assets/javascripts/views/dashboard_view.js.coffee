class Awesomeness.Views.DashboardView extends Backbone.View
  el: '#dashboard-box'

  initialize: () ->
    @initTemplate()

  initTemplate: () ->
    source = $('#dashboard-template').html()
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