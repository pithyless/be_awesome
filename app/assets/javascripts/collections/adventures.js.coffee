class Awesomeness.Collections.Adventures extends Backbone.Collection
  model: Awesomeness.Models.AdventureShort
  url: awesomeConfig.ws.adventuresUrl
  
  initialize: () ->
    
  getAdventures: ->
    @fetch
      success: () =>
        console.log('success')
      error: () =>
        console.log('error')
        @trigger('error')