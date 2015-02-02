Journal.Views.IndexItem = Backbone.View.extend({
  template: JST["posts/indexItem"],
  tagName: 'li',
  className: 'itemClick',
  events: {
    "click .post-delete" : "deletePost",
    "click" : 'selectItem',
  },

  render: function(){
    var that = this;
    this.model.fetch({
      success: function(){
        var itemContent = that.template({ item: that.model });
        that.$el.html(itemContent);

      }.bind(this)

    })
    return this;
  },

  deletePost: function(event){
    event.preventDefault();
    this.model.destroy()
  },

  selectItem: function(event) {
    event.preventDefault();
    Backbone.history.navigate(
      "/posts/" + this.model.id, {trigger: true}
    );
  }
});
