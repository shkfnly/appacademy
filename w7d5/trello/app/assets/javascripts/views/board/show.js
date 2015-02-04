TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST['board/show'],

  className: "board",

  events: {
    'sortstop .lists': 'updateSort'
  },

  initialize: function(){
    this.listCollection = this.model.lists()
    this.listenTo(this.model, 'sync change', this.render);
    this.listenTo(this.listCollection, 'add', this.listHelper);
    // this.listenTo(this.listCollection, 'change', this.render)
    this.listCollection.each(function(list){
      this.listHelper(list);
    }.bind(this));
  },

  render: function(){
    var content = this.template({board: this.model});
    this.$el.html(content);
    this.attachSubviews();
    this.$("div .lists").sortable({
      // stop: function(event, ui){
      //   ui.item.trigger('drop', ui.item.index());
      // }
    });
    this.$("div #sortable").sortable({
      connectWith: "div #sortable"
    });
    var newList = new TrelloClone.Models.List()
    var view = new TrelloClone.Views.ListForm({ board: this.model, model: newList, collection: this.listCollection})
    this.$el.append(view.render().$el);
    return this;
  },

  listHelper: function(list){
    var view = new TrelloClone.Views.ListItem({model: list});
    this.addSubview(".lists", view)
  },

  updateSort: function(event, model, position){
    // this.removeSubview('.lists', view)
    debugger
    this.listCollection.each(function(model, index){
      if(model.id != thatModel.id){
      var ord = index;
        if (index >= position){
          ord += 1;
        }
        model.set('ord', ord);
        model.save();
    } }.bind(this));
    model.set('ord', position);
    model.save();


    this.listCollection.add(model, {merge: true});
    // var ids = this.listCollection.pluck('id');
     _.sortBy(this.subviews('.lists'), function(view){
      return view.model.get('ord')
    })
  }



 


})