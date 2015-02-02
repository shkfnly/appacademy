Journal.Views.PostsIndex = Backbone.View.extend({
  template: JST['posts/postsindex'],
  initialize: function(){
    this.listenTo(this.collection, "remove add change:title reset", this.render)
  },

  events: {
    "click .newPost" : "newPost"
  },

  render: function(){
    this.collection.fetch(
      {
        success: function(){
          var that = this

          that.$el.html("<ul class='posts-list'></ul>");

          that.collection.each(function(post) {
            var view = new Journal.Views.IndexItem({ model: post});

            that.$el.find('.posts-list').append(view.render().$el);
          });
          that.$el.append("<button class='newPost'>Create New Post</button>");
        }.bind(this)
      }
    )
    return this;
  },

  newPost: function(event){
    event.preventDefault();
    
  }

});
