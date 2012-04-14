class Awesomeness.Views.HeaderView extends Backbone.View
  el: '#header'

  initialize: () ->
    @initEvents()

  initEvents: () ->
    $(window).on 'scroll', () =>
      @controlPosition()

    $(window).on 'resize', () =>
      @controlPosition()

  controlPosition: () ->
    windowTopScroll = $(window).scrollTop()

    @$el.css
      top: windowTopScroll