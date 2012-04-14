class Awesomeness.Collections.Supportings extends Backbone.Collection
  model: Awesomeness.Models.AdventureShort
  url: awesomeConfig.ws.supportingsUrl
  
  initialize: () ->
    @fetch
      success: =>
        console.log('Collections.Supportings fetch success')
      error: =>
        console.log('Collections.Supportings fetch error')
    
  toRender: ->
    @toJSON()