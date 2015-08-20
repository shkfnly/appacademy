NewsReader.Models.Entry = Backbone.Model.extend({
  urlRoot: function(){
    return this.feed.url() + '/entries'},

  initialize: function(options) {
    this.feed = options.feed
  },

})
