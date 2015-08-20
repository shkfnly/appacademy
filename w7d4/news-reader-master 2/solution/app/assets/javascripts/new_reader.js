window.NewReader = {
    Models: {},
    Collections: {},
    Views: {},
    Routers: {},
    initialize: function() {
      var $rootEl = $('#content');
      var $sidebar = $('#sidebar');
      var feeds = new NewReader.Collections.Feeds();
      feeds.fetch();

      // install the sidebar external to the router as it is
      // independent of any routing
      var feedsIndexView = new NewReader.Views.FeedsIndex({
        collection: feeds
      });
      $sidebar.html(feedsIndexView.render().$el);

      new NewReader.Routers.FeedRouter(feeds, $rootEl);
      Backbone.history.start();
    }
};

Backbone.CompositeView = Backbone.View.extend({
  subviews: function(selector) {
    this._subviews = this._subviews || {};
    
    if (!selector) {
      return this._subviews;
    } else {
      this._subviews[selector] = this._subviews[selector] || [];
      return this._subviews[selector];
    }
  },
  
  addSubview: function(selector, subview) {
    this.subviews(selector).push(subview);
    this.attachSubview(selector, subview.render());
  },
  
  attachSubview: function (selector, subview) {
    this.$(selector).append(subview.$el);
    subview.delegateEvents();
  },
  
  attachSubviews: function() {
    var view = this;
    _(view.subviews()).each(function (subviews, selector) {
      view.$(selector).empty();
      _(subviews).each(function (subview) {
        view.attachSubview(selector, subview);
      })
    })
  },
  
  remove: function() {
    Backbone.View.prototype.remove.call(this);
    _(this.subviews()).each(function (subviews, selector) {
      _(subviews).each(function (subview) {
        subview.remove();
      })
    })
  }
})
