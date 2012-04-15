class Awesomeness.Views.PingAdventureFormView extends Awesomeness.Views.FormView
  el: '#ping-adventure-form'
  elErrorMsg: '#ping-adventure-form-error-msg'
  elSuccessMsg: '#ping-adventure-form-success-msg'
  ajaxUrl: awesomeConfig.forms.pingAdventureUrl

  initialize: ->
    super(@el, @elErrorMsg)

  send: (dataToSend) ->
    $.ajax
      url: @ajaxUrl
      type: 'POST'
      data: dataToSend
      success: (data) =>
        if data.status == 'OK'
          @onSuccess(data.adventure_id)
      error: (msg) ->
        console.log('ajax error', msg)

  onSuccess: (adventureId) ->
    @$el.slideUp()
    $(@elSuccessMsg).slideDown()
    setTimeout(
      =>
        @trigger('success', adventureId)
      ,
      1500)