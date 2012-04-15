class Awesomeness.Views.ModeSwitcherView extends Backbone.View
  el: '#mode-switcher'

  events:
    "click a": "handleClick"

  initialize: () ->
    hash = window.location.hash
    @$el.find('a').each (index, item) ->
      href = $(item).attr('href')
      if href == hash
        $(item).parent().addClass('active')

  handleClick: (e) ->
    @$el.find('li').removeClass('active')
    $(e.target).parent().addClass('active')
    
