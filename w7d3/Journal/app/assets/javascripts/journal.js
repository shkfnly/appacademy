window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
  }
};

$(document).ready(function(){
  Journal.initialize();
  new Journal.Routers.PostRouter('.main');

  Backbone.history.start();
});
