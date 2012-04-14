class Awesomeness.Models.Supporters extends Backbone.Model
  urlRoot: awesomeConfig.ws.supportersUrlRoot
  
  initialize: () ->
    @fetch
      success: =>
        console.log('Models.Supporters fetch success')
      error: =>
        console.log('Models.Supporters fetch error')
    
  toRender: ->
    @toJSON()