class Awesomeness.Views.AddNewPostFormView extends Awesomeness.Views.FormView
  el: '#add-new-post-form'
  elErrorMsg: '#add-new-post-form-error-msg'

  initialize: ->
    super(@el, @elErrorMsg)
