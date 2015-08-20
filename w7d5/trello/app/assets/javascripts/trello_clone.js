window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new TrelloClone.Routers.Router({$rootEl : '#main'});

  }
};


$(document).ready(function(){
  TrelloClone.initialize();
  Backbone.history.start();
});