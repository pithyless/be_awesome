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
    @adventureView = new Awesomeness.Views.AdventureView()

  bindRouterEvents: ->
    @router.bind('newAdventure', @onNewAdventure, @)
    @router.bind('getAdventuresList', @onGetAdventuresList, @)
    @router.bind('getAdventure', @onGetAdventure, @)

  onNewAdventure: ->
    console.log("new adventure")

  onGetAdventuresList: ->
    adventuresToRender = @adventuresCollection.toRender()
    @adventuresListView.render(adventuresToRender)

  onGetAdventure: (id) ->
    console.log("adventure no", id)
    adventure = new Awesomeness.Models.Adventure({id: id})
    adventureToRender = adventure.toRender()
    @adventureView.render(adventureToRender)