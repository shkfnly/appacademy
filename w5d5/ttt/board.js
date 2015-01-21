var _ = require("./helper")
var _ = new _();
function Board () {
  this.grid = []
  this.generateGrid();

}



Board.prototype.generateGrid = function(){
  var i = 0;
  while(i < 3) {
    this.grid.push([]);
    var j = 0;
    while(j < 3) {
      this.grid[i].push(" ");
      j++;
    }
    i++;
  }

}

Board.prototype.print = function(){
  for(var i= 0; i < this.grid.length; i++)
  {console.log(JSON.stringify(this.grid[i]));}
}

Board.prototype.won = function(){
  if(this.win_helper('X', this.grid) ||
     this.win_helper('X', _.transpose(this.grid)) ||
     this.diagonal_winner('X')){
       return [true, 'X']
     }
  else if(this.win_helper('O', this.grid) ||
          this.win_helper('O', _.transpose(this.grid)) ||
          this.diagonal_winner('O')){
       return [true, 'O']
     }
  else{
    return [false];
  }
}

Board.prototype.atPosition = function (pos) {
  var x = pos[0];
  var y = pos[1];
  return this.grid[x][y]
}

Board.prototype.win_helper = function(symb, grid){
  return _.some(grid, function(row){
    return _.every(row, function(cell){
      return cell == symb;
    })
  })
}

Board.prototype.diagonal_positions = [
                     [[0,0], [1, 1], [2, 2]],
                     [[0,2], [1, 1], [2, 0]]
                     ]

Board.prototype.diagonal_winner = function(symb){
  return _.some(this.diagonal_positions, function(row){
    return _.every(row, function(cell){
      return this.atPosition(cell) == symb;
    }.bind(this))
  }.bind(this))
}

Board.prototype.winner = function(){
  var wonTest = this.won();
  if (wonTest[0]){
    return wonTest[1];
  }
  else{
    return false;
  }
}


Board.prototype.tied - function(){
  
}

Board.prototype.empty= function(pos){
  var x = pos[0];
  var y = pos[1];
  return this.grid[x][y] === " ";
}


Board.prototype.placeMark = function(pos, mark){
  if(this.empty(pos)){
    var x = pos[0];
    var y = pos[1];
    this.grid[x][y] = mark;
    return true;
  }
  else {
    console.log("invalid move");
    return false;
  }
}

module.exports = Board;




//
