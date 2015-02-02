NewsReader.Views.FeedIndexItem = Backbone.View.extend({

  template: JST['feeds/indexItem'],

  tagName: "li",

  events: {
    "click .delete" : 'deleteFeed'
  },

  render: function() {
    var content = this.template({feed: this.model});
    this.$el.html(content);
    return this;
  },

  deleteFeed: function(){
    this.model.destroy();
  }

})
