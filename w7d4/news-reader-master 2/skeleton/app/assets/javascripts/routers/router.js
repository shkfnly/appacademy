NewsReader.Routers.Router = Backbone.Router.extend({
  routes: {
    '' : 'index',
    'feeds/:id' : 'feedShow',
    'sessions/new': 'newSession'
  },

  index: function(){
    var view = new NewsReader.Views.FeedIndex({collection: NewsReader.Collections.feed})
    view.collection.fetch({
      success: function(){
        this._swapView(view);
      }.bind(this)
    });
  },

  feedShow: function(id) {
    var feed = NewsReader.Collections.feed.getOrFetch(id);
    feed.fetch({
      success: function() {
        var view = new NewsReader.Views.FeedShow({model: feed});
        this._swapView(view);
      }.bind(this)
    });
  },

  newSession: function() {
    var view = new NewsReader.Views.UserForm();
    view.render();
    this._swapView(view);
  },

  _swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    $('#content').html(newView.$el);
  },

})
