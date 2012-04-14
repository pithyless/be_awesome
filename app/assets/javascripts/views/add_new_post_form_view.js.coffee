class Awesomeness.Views.AddNewPostFormView extends Awesomeness.Views.FormView
  el: '#add-new-post-form'
  elErrorMsg: '#add-new-post-form-error-msg'
  ajaxUrl: awesomeConfig.forms.addNewPostUrl

  initialize: ->
    super(@el, @elErrorMsg)

  send: (dataToSend) ->
    $.ajax
      url: @ajaxUrl
      type: 'POST'
      data: dataToSend
      success: (data) =>
        console.log('ajax success', data)
      error: (msg) ->
        console.log('ajax error', msg)
