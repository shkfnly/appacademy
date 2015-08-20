Journal.Collections.Posts = Backbone.Collection.extend({
  url: '/posts',
  model: Journal.Models.Post,

  getOrFetch: function(id){
    var post = this.get(id);
    if(!post){
      var that = this;
      post = new Journal.Models.Post({id: id});
      post.fetch({
        success: function(){
          that.add(post);
        }
      })
    };
    return post;
  }
})

Journal.Collections.posts = new Journal.Collections.Posts();
