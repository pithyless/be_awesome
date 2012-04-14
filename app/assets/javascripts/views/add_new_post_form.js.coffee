class Awesomeness.Views.AddNewPostFormView extends Backbone.View
  el: '#add-new-post-form'
  elErrorMsg: '#add-new-post-form-error-msg'

  initialize: ->
    @initSendEvent()
    console.log('form inited')

  initSendEvent: ->
    @$el.find('.button').on 'click', (e) =>
      e.preventDefault()
      if @validate()
        dataToSend = @$el.serialize()
        @send(dataToSend)

  validate: ->
    val = @$el.find('textarea').val()
    if val.length > 0
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