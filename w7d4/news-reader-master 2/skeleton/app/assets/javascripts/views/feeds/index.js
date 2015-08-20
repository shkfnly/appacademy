NewsReader.Views.FeedIndex = Backbone.View.extend({

  template: JST['feeds/index'],

  initialize: function(){
    this.listenTo(this.collection, 'sync', this.render);
    this.listenTo(this.collection, 'destroy', this.render)
  },

  render: function() {
    var content = this.template();
    this.$el.html(content);
    this.collection.each(function(feed){
      var view = new NewsReader.Views.FeedIndexItem({ model: feed })
      this.$("ul").append(view.render().$el)
    })
    var newFeed = new NewsReader.Models.Feed();
    var view = new NewsReader.Views.FeedForm({ model: newFeed, collection: this.collection });
    this.$el.append(view.render().$el)
    return this;
  },

})
