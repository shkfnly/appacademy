NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST['feeds/show'],

  events: {
    "click .refresh": "refresh"
  },

  initialize: function(){
    this.listenTo(this.model, 'sync', this.render)
  },

  render: function(){
    var content = this.template();
    this.$el.html(content);
    this.model.entries().each(function(entry){
      var view = new NewsReader.Views.FeedShowItem({ model: entry })
      this.$("ul").append(view.render().$el)
    })
    return this;
  },

  refresh: function (){
    this.model.fetch({
      success: function(){
        this.render();
      }.bind(this)
    })
  }
})
