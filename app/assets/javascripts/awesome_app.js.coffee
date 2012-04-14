$ ->
  new AwesomeApp()

class AwesomeApp
  constructor: ->

    @router = new Awesomeness.Routers.AwesomeRouter()
    Backbone.history.start({pushState: false})

    @bindRouterEvents()

    # init views
    @adventuresListView = new Awesomeness.Views.AdventuresListView()
    @adventureView = new Awesomeness.Views.AdventureView()
    @newAdventureView = new Awesomeness.Views.NewAdventureView()
    @homePageView = new Awesomeness.Views.HomePageView()

  bindRouterEvents: ->
    @router.bind('newAdventure', @onNewAdventure, @)
    @router.bind('getAdventuresList', @onGetAdventuresList, @)
    @router.bind('getAdventure', @onGetAdventure, @)

  onNewAdventure: ->
    @clearAllViews()
    @newAdventureView.render()
    @addNewAdventureFormView = new Awesomeness.Views.AddNewAdventureFormView()

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
    @addNewPostFormView = new Awesomeness.Views.AddNewPostFormView()

  clearAllViews: ->
    @adventureView.clear()
    @adventuresListView.clear()
    @newAdventureView.clear()
    @homePageView.clear()