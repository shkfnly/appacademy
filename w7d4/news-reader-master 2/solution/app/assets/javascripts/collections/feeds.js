NewReader.Collections.Feeds = Backbone.Collection.extend({
  model: NewReader.Models.Feed,

  url: 'api/feeds',

  getOrFetch: function (id) {
    var feedMaybe = this.get(id);
    if (!feedMaybe) {
      feedMaybe = new NewReader.Models.Feed({ id: id });
      feedMaybe.fetch({
        success: function() {
          that.add(feedMaybe);
        }.bind(this)
      });
    }
    return feedMaybe;
  },

  getOrFetchEntry: function (feedId, entryId) {
    var feedMaybe = this.get(feedId);
    var entry;
    if(feedMaybe) {
      entry = feedMaybe.entries().getOrFetch(entryId);
      return entry;
    }
    entry = new NewReader.Models.Entry({ id: entryId });
    entry.fetch();
    return entry;
  },
});
