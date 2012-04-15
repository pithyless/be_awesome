class Awesomeness.Routers.AwesomeRouter extends Backbone.Router

  routes:
    "adventures": "getAdventuresList"
    "adventures/new": "newAdventure"
    "adventures/:id": "getAdventure"
    "adventures/:id/supporters": "getSupporters"
    "dashboard": "getDashboard"
    "menu": "getMenu"

  newAdventure: ->
    @trigger('newAdventure')

  getAdventuresList: ->
    @trigger('getAdventuresList')

  getAdventure: (id) ->
    @trigger('getAdventure', id)

  getSupporters: (id) ->
    @trigger('getSupporters', id)

  getDashboard: ->
    @trigger('getDashboard')

  getMenu: ->
    @trigger('getMenu')
  