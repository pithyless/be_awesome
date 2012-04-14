class Awesomeness.Views.AddNewAdventureFormView extends Awesomeness.Views.FormView
  el: '#add-new-adventure-form'
  elErrorMsg: '#add-new-adventure-form-error-msg'

  initialize: ->
    super(@el, @elErrorMsg)
