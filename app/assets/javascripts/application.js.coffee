#= require_self
#= require jquery
#= require jquery_ujs
#= require libs/underscore-min
#= require libs/backbone-min
#= require libs/handlebars-1.0.0.beta.6
#= require_tree .

unless window.Awesomeness?
  window.Awesomeness =
    Models: {}
    Collections: {}
    Routers: {}
    Views: {}