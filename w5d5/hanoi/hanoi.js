var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function Hanoi(disks, name) {
  this.name = name
  this.board = [[],[],[]];
  this.disks = disks;
  this.generateGame();
}

Hanoi.prototype.generateGame = function(){
  i = 1;
  while(i <= this.disks){
    this.board[0].push(i);
    i++;
  }
}

Hanoi.prototype.isWon = function(){
  if(this.board[2].length == this.disks){
    return true;
  } else{
    return false;
  }
}

Hanoi.prototype.isValidMove = function(sTI, eTI){
  if((typeof(this.board[eTI][0]) === "undefined" && typeof(this.board[sTI][0]) !== "undefined")
    || this.board[sTI][0] < this.board[eTI][0]){
    return true;
  } else {
    return false;
  }
}

Hanoi.prototype.move = function(sTI, eTI){
  if(this.isValidMove(sTI, eTI)){
    var piece = this.board[sTI].shift();
    this.board[eTI].unshift(piece);
    return true;
  }
  else{
    return false;
  }
}

Hanoi.prototype.print = function(){
  var boardString = JSON.stringify(this.board);
  console.log(boardString);
}

Hanoi.prototype.promptMove =  function(callback){
  this.print();
  reader.question("Where would you like to move from?", function(startindstring){
    reader.question("Where would you like to move to?", function(endindstring){
      var startind = parseInt(startindstring);
      var endind = parseInt(endindstring);
      callback(startind - 1, endind - 1)
    })
  })
}

Hanoi.prototype.run = function(completionCallback){
  this.promptMove(function(s, e){
    var moved = this.move(s, e)
    if(!moved){
      console.log("Invalid Move")
      this.run(completionCallback.bind(this))
    }
    else if(this.isWon()){
      completionCallback();
    }
    else {
      this.run(completionCallback.bind(this));
    }
  }.bind(this))
}

var game = new Hanoi(3, "Yay");

game.run(function(){
  console.log(this.name + " you win!");
  reader.close();
})

// console.log(game.board);
