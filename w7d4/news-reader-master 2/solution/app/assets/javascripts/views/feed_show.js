NewReader.Views.FeedShow = Backbone.View.extend({
  template: JST['feeds/show'],

  className: 'feed-show',

  initialize: function (attribute) {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.entries(), 'sync', this.render);
  },

  events: {
    'click .refresh-entries': 'refresh'
  },

  render: function () {
    var content = this.template({
      feed: this.model
    });
    this.$el.html(content);
    return this;
  },

  refresh: function () {
    this.model.entries().fetch({
      error: function () {
        console.log('Could not refresh view for some reason');
      }
    });
  }
});
