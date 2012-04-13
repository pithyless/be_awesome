class Awesomeness.Models.Adventure extends Backbone.Model
  urlRoot: awesomeConfig.ws.adventureUrlRoot

  initialize: ->
    @fetch
      success: =>
        console.log('Models.Adventure fetch success', @id)
      error: =>
        console.log('Models.Adventure fetch error', @id)

  toRender: ->
    @toJSON()