class Awesomeness.Views.AdventureView extends Backbone.View
  initialize: () ->
    console.log('adventure view init')
    
  render: (data) ->
    console.log('render adventure view', data)