class Awesomeness.Views.AddNewAdventureFormView extends Awesomeness.Views.FormView
  el: '#add-new-adventure-form'
  elErrorMsg: '#add-new-adventure-form-error-msg'
  ajaxUrl: awesomeConfig.forms.addNewAdventureUrl

  initialize: ->
    super(@el, @elErrorMsg, @ajaxUrl)
