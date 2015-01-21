var Board = require("./board");

function Game(readerInterface) {
  this.board = new Board();
  this.reader = readerInterface;
  this.player = "X";
}

Game.prototype.switchPlayer = function(){
  if (this.player === "X"){
    this.player = "O";
  }
  else{
    this.player = "X";
  }
}

Game.prototype.run = function(completionCallback){
  this.promptMove(function(position){
    if(this.board.placeMark(position, this.player)){
      if(this.board.winner() === false){
        this.switchPlayer();
        this.run(completionCallback)
      }
      else{
        var winSym = this.board.winner();
        completionCallback(winSym);
      }
    }
    else{
      this.run(completionCallback)
    }
  }.bind(this))
}

Game.prototype.promptMove = function(callback){
  this.board.print();
  this.reader.question("Where would you like to move " + this.player + " (x, y)", function(positionstring){
    var position = positionstring.split(',').map(function(item){
      return parseInt(item);
    })
    callback(position, this.player)
  })
}

module.exports = Game;
