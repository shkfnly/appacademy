NewsReader.Views.UserForm = Backbone.View.extend({
  template: JST['user/form'],

  render: function(){
    var user = new NewsReader.Models.User()
    var content = this.template({user: user})
    return this;
  }
})
