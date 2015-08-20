NewsReader.Views.FeedForm = Backbone.View.extend({
  template: JST['feeds/form'],

  events: {
    "submit":"createFeed"
  },

  tagName: "form",

  className: "new",

  render: function(){
    var content = this.template({feed: this.model});
    this.$el.html(content);
    return this;
  },

  createFeed: function(event) {
    event.preventDefault();
    var data = $(event.target).serializeJSON();
    this.model.save(data, {
      success: function(){
        this.collection.add(this.model);
      }.bind(this)
    })
  },
})
