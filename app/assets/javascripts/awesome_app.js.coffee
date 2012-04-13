$ ->
  new AwesomeApp()

class AwesomeApp
  constructor: ->
    @router = new Awesomeness.Routers.AwesomeRouter()
    Backbone.history.start
      root: "/adventures"

    @bindRouterEvents()

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
    @adventuresCollection = new Awesomeness.Collections.Adventures()
    @adventuresCollection.bind('reset', @onAdventuresCollectionReady, @)

  onAdventuresCollectionReady: ->
    @clearAllViews()
    adventuresToRender = @adventuresCollection.toRender()
    @adventuresListView.render(adventuresToRender)

  onGetAdventure: (id) ->
    @adventureModel = new Awesomeness.Models.Adventure({id: id})
    @adventureModel.bind('change', @onAdventureReady, @)
    
  onAdventureReady: ->
    @clearAllViews()
    adventureToRender = @adventureModel.toRender()
    @adventureView.render(adventureToRender)

  clearAllViews: ->
    @adventureView.clear()
    @adventuresListView.clear()