$ ->
  new AwesomeApp()

class AwesomeApp
  constructor: ->

    @router = new Awesomeness.Routers.AwesomeRouter()
    
    historyStatus = Backbone.history.start({pushState: false})

    @checkDefaultRoute(historyStatus)
    @bindRouterEvents()

    # init views
    @adventuresListView = new Awesomeness.Views.AdventuresListView()
    @adventureView = new Awesomeness.Views.AdventureView()
    @newAdventureView = new Awesomeness.Views.NewAdventureView()
    @homePageView = new Awesomeness.Views.HomePageView()

  checkDefaultRoute: (historyStatus) ->
    # console.log('window.location.hash', window.location.hash, window.location.hash.length, historyStatus)
    if historyStatus
      @router.navigate(window.location.hash, {trigger: true})
    else
      window.location.hash = ''

  bindRouterEvents: ->
    @router.bind('newAdventure', @onNewAdventure, @)
    @router.bind('getAdventuresList', @onGetAdventuresList, @)
    @router.bind('getAdventure', @onGetAdventure, @)
    @router.bind('getSupporters', @onGetSupporters, @)

  onNewAdventure: ->
    @clearAllViews()
    @newAdventureView.render()
    @addNewAdventureFormView = new Awesomeness.Views.AddNewAdventureFormView()
    @addNewAdventureFormView.bind('success', @onNewAdventureAdded, @)

  onNewAdventureAdded: (adventureId) ->
    @router.navigate("adventures/" + adventureId, {trigger: true})

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
    @addNewPostFormView.bind('success', @onNewPostAdded, @)

  onNewPostAdded: ->
    @router.navigate("adventures", {trigger: true})

  clearAllViews: ->
    @adventureView.clear()
    @adventuresListView.clear()
    @newAdventureView.clear()
    @homePageView.clear()

  # initMenu: ->
  #   $('#menu-button').on 'click', (e) ->
  #     e.preventDefault()

  #     el = $(e.target).attr('href')
  #     destination = $(el).offset().top - 20
  #     $("html:not(:animated), body:not(:animated)").animate
  #       scrollTop:
  #         destination
  #       'normal'

  onGetSupporters: (id) ->
    @clearAllViews()
    supportersView = new Awesomeness.Views.SupportersView()
    supportersView.render()
