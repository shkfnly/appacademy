require 'rspec'
require 'minesweeper'

describe "#Board.new.board" do
  expect(Board.new.board).to eq ()
