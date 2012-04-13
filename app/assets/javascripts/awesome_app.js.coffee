$ ->
  new AwesomeApp()

class AwesomeApp
  constructor: ->
    @router = new Awesomeness.Routers.AwesomeRouter()
    Backbone.history.start()
    @bindRouterEvents()

    # init collections
    @adventuresCollection = new Awesomeness.Collections.Adventures()

    # init views
    @adventuresListView = new Awesomeness.Views.AdventuresListView()

  bindRouterEvents: ->
    @router.bind('newAdventure', @onNewAdventure, @)
    @router.bind('getAdventuresList', @onGetAdventuresList, @)
    @router.bind('getAdventure', @onGetAdventure, @)

  onNewAdventure: ->
    console.log("new adventure")

  onGetAdventuresList: ->
    adventures = @adventuresCollection.getAdventures()
    @adventuresListView.render(adventures)

  onGetAdventure: (id) ->
    console.log("adventure no", id)