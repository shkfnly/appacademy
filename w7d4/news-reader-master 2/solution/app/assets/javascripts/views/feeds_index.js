NewReader.Views.FeedsIndex = Backbone.CompositeView.extend({
  template: JST['feeds/index'],

  initialize: function () {
    this.listenTo(this.collection, 'add', this.addFeedSubview);
    this.listenTo(this.collection, 'sync add', this.render);
    var view = this;
    this.collection.each(function (feed) {
      view.addFeedSubview(feed);
    });
  },

  addFeedSubview: function (feed) {
    var feedListItem = new NewReader.Views.FeedListItem({
      model: feed
    });
    this.addSubview("ul.feeds-index", feedListItem);
  },

  events: {
    'click .add-button': 'addFeed'
  },

  render: function () {
    this.$el.html(this.template());
    this.attachSubviews();
    return this;
  },

  addFeed: function (event) {
    event.preventDefault();
    var newUrl = this.$('input').val();
    var newFeed = new NewReader.Models.Feed({
      'url': newUrl
    });

    newFeed.save({}, {
      success: function () {
        this.collection.add(newFeed);
      }.bind(this)
    });
  }
});
