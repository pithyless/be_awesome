class Awesomeness.Collections.Adventures extends Backbone.Collection
  model: Awesomeness.Models.Adventure
  url: awesomeConfig.ws.getAdventuresUrl
  
  initialize: () ->
    
  getAdventures: ->
    @fetch
      success: () =>
        console.log('success')
      error: () =>
        console.log('error')
        @trigger('error')