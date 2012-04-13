$ ->
  new AwesomeApp()

class AwesomeApp
  constructor: ->
    @router = new Awesomeness.Routers.AwesomeRouter()
    Backbone.history.start()

    # init views
    @adventuresListView = new Awesomeness.Views.AdventuresListView()

    @bindEvents()

  bindEvents: ->
    @router.bind('newAdventure', @onNewAdventure, @)
    @router.bind('getAdventuresList', @onGetAdventuresList, @)
    @router.bind('getAdventure', @onGetAdventure, @)

  onNewAdventure: ->
    console.log("new adventure")

  onGetAdventuresList: ->
    @adventuresListView.render()

  onGetAdventure: (id) ->
    console.log("adventure no", id)