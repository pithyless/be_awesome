class Awesomeness.Views.ModeSwitcherView extends Backbone.View
  el: '#mode-switcher'

  events:
    "click a": "handleClick"

  initialize: () ->
    hash = window.location.hash
    @$el.find('a').each (index, item) ->
      href = $(item).attr('href')
      if href == hash
        $(item).addClass('active')

  handleClick: (e) ->
    @$el.find('a').removeClass('active')
    $(e.target).addClass('active')
    
