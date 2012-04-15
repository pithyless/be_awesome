$ ->
  new AwesomeApp()

class AwesomeApp
  constructor: ->

    # init views
    @adventuresListView = new Awesomeness.Views.AdventuresListView()
    @adventureView = new Awesomeness.Views.AdventureView()
    @newAdventureView = new Awesomeness.Views.NewAdventureView()
    @homePageView = new Awesomeness.Views.HomePageView()
    @supportersView = new Awesomeness.Views.SupportersView()
    @dashboardView = new Awesomeness.Views.DashboardView()
    @modeSwitcherView = new Awesomeness.Views.ModeSwitcherView()
    @menuView = new Awesomeness.Views.MenuView()
    @meterView = new Awesomeness.Views.MeterView()

    @router = new Awesomeness.Routers.AwesomeRouter()
    @bindRouterEvents()
    historyStatus = Backbone.history.start({pushState: false})

    @checkDefaultRoute(historyStatus)

  checkDefaultRoute: (historyStatus) ->
    
    if awesomeConfig.isUserAuthorized
      $('#header').show()
      @router.navigate("adventures", {trigger: true}) unless historyStatus
    else
      $('#header').hide()
      @router.navigate("", {trigger: true})

  bindRouterEvents: ->
    @router.bind('newAdventure', @onNewAdventure, @)
    @router.bind('getAdventuresList', @onGetAdventuresList, @)
    @router.bind('getAdventure', @onGetAdventure, @)
    @router.bind('getSupporters', @onGetSupporters, @)
    @router.bind('getDashboard', @onGetDashboard, @)
    @router.bind('getMenu', @onGetMenu, @)
    @router.bind('getMeter', @onGetMeter, @)

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

    @pingAdventureFormView = new Awesomeness.Views.PingAdventureFormView()
    @pingAdventureFormView.bind('success', @onNewPostAdded, @)

    @abandonAdventureFormView = new Awesomeness.Views.AbandonAdventureFormView()
    @abandonAdventureFormView.bind('success', @onNewPostAdded, @)

  onNewPostAdded: (adventureId) ->
    @router.navigate("adventures", {replace: true})
    @router.navigate("adventures/" + adventureId, {trigger: true})

  clearAllViews: ->
    @adventureView.clear()
    @adventuresListView.clear()
    @newAdventureView.clear()
    @homePageView.clear()
    @supportersView.clear()
    @dashboardView.clear()
    @menuView.clear()
    @meterView.clear()

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

  onGetMenu: ->
    @clearAllViews()
    @menuView.render()

  onGetMeter: ->
    @clearAllViews()
    @meterView.render()