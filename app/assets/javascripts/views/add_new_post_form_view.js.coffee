class Awesomeness.Views.AddNewPostFormView extends Awesomeness.Views.FormView
  el: '#add-new-post-form'
  elErrorMsg: '#add-new-post-form-error-msg'
  elSuccessMsg: '#add-new-post-form-success-msg'
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
        if data.status == 'OK'
          @onSuccess()
      error: (msg) ->
        console.log('ajax error', msg)

  onSuccess: ->
    @$el.slideUp()
    $(@elSuccessMsg).slideDown()
    setTimeout(
      =>
        @trigger('success')
      ,
      1500)
