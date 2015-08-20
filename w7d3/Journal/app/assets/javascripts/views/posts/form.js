Journal.Views.PostForm = Backbone.View.extend({
  template: JST['posts/post_form'],
  tagName: 'form',
  events: {
    'submit': 'savePost'
  },

  render: function() {
    var formContent = this.template({ post: this.model})
    this.$el.html(formContent);
    return this;
  },

  savePost: function(event) {
    event.preventDefault();

    var $form = $(event.currentTarget);
    var data = $form.serializeJSON().post;
    this.model.save(data, {
      success: function() {
        this.collection.add(this.model, {merge: true });
        Backbone.history.navigate('', {
          trigger: true
        });
      }.bind(this),
      error: function(){
        alert("error please enter valid info")
        this.render();
      }.bind(this)
    });

  }

});
