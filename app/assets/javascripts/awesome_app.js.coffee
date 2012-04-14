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
    @supportersView = new Awesomeness.Views.SupportersView()
    @dashboardView = new Awesomeness.Views.DashboardView()

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
    @router.bind('getDashboard', @onGetDashboard, @)

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
    @supportersView.clear()
    @dashboardView.clear()

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
    @supporters = new Awesomeness.Models.Supporters({id: id})
    @supporters.bind('change', @onSupportersModelReady, @)

  onSupportersModelReady: ->
    @clearAllViews()
    supportersToRender = @supporters.toRender()
    @supportersView.render(supportersToRender)

  onGetDashboard: ->
    @supportingsCollection = new Awesomeness.Collections.Supportings()
    @supportingsCollection.bind('reset', @onSupportingsCollectionReady, @)

  onSupportingsCollectionReady: ->
    @clearAllViews()
    supportingsToRender = @supportingsCollection.toRender()
    @dashboardView.render(supportingsToRender)