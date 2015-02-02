NewReader.Views.FeedListItem = Backbone.View.extend({
  tagName: "li",

  template: JST["feeds/feed_list_item"],

  render: function () {
    var content = this.template({ 
      feed: this.model
    });
    this.$el.append(content);

    return this;
  }
})
