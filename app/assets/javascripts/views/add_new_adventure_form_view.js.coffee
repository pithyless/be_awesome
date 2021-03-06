class Awesomeness.Views.AddNewAdventureFormView extends Awesomeness.Views.FormView
  el: '#add-new-adventure-form'
  elErrorMsg: '#add-new-adventure-form-error-msg'
  elSuccessMsg: '#add-new-adventure-form-success-msg'
  ajaxUrl: awesomeConfig.forms.addNewAdventureUrl

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
