#= require_self
#= require jquery
#= require jquery_ujs
#= require libs/underscore-min
#= require libs/backbone-min
#= require libs/handlebars-1.0.0.beta.6
#= require libs/jquery.positioner
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./routers
#= require_tree ./views/generic
#= require_tree ./views
#= require_tree .

unless window.Awesomeness?
  window.Awesomeness =
    Models: {}
    Collections: {}
    Routers: {}
    Views: {}
