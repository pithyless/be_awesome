class Awesomeness.Views.FormView extends Backbone.View
  
  initialize: (@el, @elErrorMsg) ->
    @initSendEvent()

  initSendEvent: ->
    @$el.find('.button').on 'click', (e) =>
      e.preventDefault()
      if @validate()
        dataToSend = @$el.serialize()
        @send(dataToSend)

  validate: ->
    valid = true
    $inputs = @$el.find('[name]')
    
    $inputs.each (index, item) ->
      val = $(item).val()

      unless val.length > 0
        valid = false

    if valid
      $(@elErrorMsg).hide()
      return true
    else
      $(@elErrorMsg).show()
      return false

  send: (dataToSend) ->
    $.ajax
      url: awesomeConfig.forms.addNewPostUrl
      type: 'POST'
      data: dataToSend
      success: (data) ->
        console.log('ajax success', data)
      error: (msg) ->
        console.log('ajax error', msg)