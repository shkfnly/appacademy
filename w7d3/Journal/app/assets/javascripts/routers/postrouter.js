Journal.Routers.PostRouter = Backbone.Router.extend({
  routes: {
    "": "index",
    "posts/new": "new",
    "posts/:id": "show"
  },
  initialize: function(el){
    this.currentView = {};
    this.el = el;
    $('.sidebar').html(this.index())
  },

  index: function() {
    var postsView = new Journal.Views.PostsIndex({ collection: Journal.Collections.posts });
    this._swap(postsView, '.sidebar');
  },

  show: function(id) {
    var postModel = Journal.Collections.posts.getOrFetch(id);
    var postView = new Journal.Views.PostShow({model: postModel});
    this._swap(postView, '.content');
    // $('.content').html(postView.render().$el);

  },

  new: function() {

    this.form();

  },

  form: function(){
    var post = new Journal.Models.Post();
    this._formView = new Journal.Views.PostForm({model: post, collection: Journal.Collections.posts})
    $(this.el).append(this._formView.$el)
    this._formView.render();
  },

  _swap: function(newView, element){
    if (this.currentView[element]) {
      this.currentView[element].remove();
    }
    $(element).html(newView.render().$el);

    this.currentView[element] = newView;
  }
});
