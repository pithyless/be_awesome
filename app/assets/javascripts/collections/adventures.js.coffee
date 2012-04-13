class Awesomeness.Collections.Adventures extends Backbone.Collection
  model: Awesomeness.Models.AdventureShort
  url: awesomeConfig.ws.adventuresUrl
  
  initialize: () ->
    @fetch
      success: =>
        console.log('Collections.Adventures fetch success')
      error: =>
        console.log('Collections.Adventures fetch error')
    
  toRender: ->
    @toJSON()