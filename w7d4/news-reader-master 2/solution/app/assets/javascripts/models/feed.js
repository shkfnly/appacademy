NewReader.Models.Feed = Backbone.Model.extend({
  urlRoot: 'api/feeds',

  parse: function (response) {
    if (response.latest_entries) {
      this.entries().set(response.latest_entries);
      delete response.latest_entries;
    }
    return response;
  },

  entries: function () {
    if (!this._entries) {
      this._entries = new NewReader.Collections.Entries([], {
        feed: this
      });
    }
    return this._entries;
  }
});
