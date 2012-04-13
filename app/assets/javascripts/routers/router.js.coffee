class Awesomeness.Routers.AwesomeRouter extends Backbone.Router

  routes:
    "/adventures": "getAdventuresList"
    "/adventures/new": "newAdventure"
    "/adventures/:id": "getAdventure"

  newAdventure: ->
    @trigger('newAdventure')

  getAdventuresList: ->
    @trigger('getAdventuresList')

  getAdventure: (id) ->
    @trigger('getAdventure', id)
  