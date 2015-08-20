var TicTacToe = require("./ttt");

var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var TTT = new TicTacToe.Game(reader);


TTT.run(function(symb){
  console.log('You win ' + symb)
  this.reader.close();
}.bind(TTT))
