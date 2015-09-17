####This repository contains work that I completed in the course of App Academy

## Prep Work for App Academy

### Twitter Clone ( [code](https://github.com/shkfnly/sample_app) | [demo](fvbkireh.herokuapp.com) )
This is the sample application for the
[*Ruby on Rails Tutorial:
Learn Web Development with Rails*](http://www.railstutorial.org/)
by [Michael Hartl](http://www.michaelhartl.com/).

## Week 1

### Towers of Hanoi ( [code](https://github.com/shkfnly/appacademy/blob/master/w1d1/towers_of_hanoi.rb) )

### Mastermind ( [code](https://github.com/shkfnly/appacademy/blob/master/w1d3/mastermind.rb) )

### Tic Tac Toe  ( [code](https://github.com/shkfnly/appacademy/tree/master/w1d5/TicTacToeAI-master/skeleton) )
This is my version of the timeless classic 2-player pencil & paper game.

### Hangman ( [code](https://github.com/shkfnly/appacademy/blob/master/w1d3/hangmanrefactor.rb) )
This is the classic hangman game, where one player thinks of a word and the other tries to guess it by suggesting letters. The program has two types of players: human player and AI player. 

![hangman](w1d3/screenshots/hangman_screenshot.png)


### Word Chains ( [code](https://github.com/shkfnly/algorithms/blob/master/word_ladder.rb) )
Given two words of equal length as command-line arguments, the program builds a chain of words connecting the first to the second. Each word in the chain is in the dictionary and every step along the chain changes exactly one letter from the previous word.


## Week 2

### Minesweeper ( [code](https://github.com/shkfnly/appacademy/tree/master/w2/w2d1) )

### Chess  ( [code](https://github.com/shkfnly/chess) )
There is a human and an ai player. I also implemented en passant.

![chess](https://github.com/shkfnly/appacademy/blob/master/images/chess.png)


### Checkers ( [code](https://github.com/shkfnly/checkers) )

![checkers](https://github.com/shkfnly/appacademy/blob/master/images/checkers.png)


## Week 3

### SQLZoo ( [code](https://github.com/shkfnly/appacademy/tree/master/w3/w3d1/sqlzoo-master) )

### URL Shortner App ( [code](https://github.com/shkfnly/appacademy/tree/master/w3/w3d3/url_shortner_app) )
URL Shortner a tool that takes an input URL and will shorten it for the user. Subsequent users can then give the shortened URL back to the application and be directed to the original URL. You can input shortened URLs into CLI and the original URL pops open in a browser (with the help of the `launchy` gem).

### Polls App ( [code](https://github.com/shkfnly/appacademy/tree/master/w3/w3d4/PollsApp) )
- Tables: `users`, `polls`, `questions`, `answer_choices`, and `responses`
- associations and validations for all models


### ActiveRecord Lite ( [code](https://github.com/shkfnly/appacademy/tree/master/w3/w3d5) )
I built my own lite version of ActiveRecord.
- implemented `my_attr_accessor` using
  - `define_method`
  - `instance_variable_get`
  - `instance_variable_set`
- used `SQLObject` to interact with the database to implement
  - `::all`
  - `::find`
  - `#insert`
  - `#update`
  - `#save`
  - `::table_name` and `::table_name=`
  - `::finalize!` which automatically adds getter and setter methods for each column
  - `#initialize`
  - `::parse_all`
- implemented associations
  - `belongs_to` and `has_many` associations, which store
    - `#foreign_key`
    - `#class_name`
    - `#primary_key`
  - `has_one_through`


## Week 4

### Blogger ( [code](https://github.com/shkfnly/twitterclientexample) )
JumpStart blogger tutorial, which can be found at [JumpStart Lab](http://tutorials.jumpstartlab.com/projects/blogger.html).

### Contacts API ( [code](https://github.com/shkfnly/appacademy/tree/master/w4/w4d1/routes_app) )

Contacts API is an application storing your email contacts.  Users can send requests to the API in order to create and share contacts, as well as retrieve their stored contact information.
- Tables: `users`, `contacts`, `contact_share`, `contact_group`, and `comments`

### 99 Cats ( [code](https://github.com/shkfnly/appacademy/tree/master/w4/w4d2d3/ninetyninecats) )
This project is a clone of the dress rental website 99dresses. In other words: it is an airbnb for renting cats.

### Music App ( [code](https://github.com/shkfnly/MusicApp) | [demo](http://musicapp.shkfnly.com/) )
**email:** user@example.com
**password:** awesome

A simplified version of a rdio-like app for browsing music. It is an inventory system for record labels. This app lets users track their Bands, Albums and Tracks.

### Reddit App ( [code](https://github.com/shkfnly/RedditApp) | [demo](http://redditapp.shkfnly.com/) )

If you don't know what the Reddit is, then you are probably someone with a life. [Here are some cats.](http://www.reddit.com/r/cats)


## Week 5

### Goal Setter App ( [code](https://github.com/shkfnly/GoalSetterApp) | [demo](http://goalsetterv.herokuapp.com/) )

This project's main focus was on improving my skills in:
- writing integration tests using `Capybara` and `RSpec`
- testing behavior rather than implementation
- learning how to develop one feature at a time
- using concerns and polymorphic associations to dry up code

### Rails Lite ( [code](https://github.com/shkfnly/RedditApp) )

I built my own lite version of Rails.
- used `WEBrick` to set my own server
- parse request
- route request to the appropriate controller
- send response back to the client

### Rails Lite integrated with Active Record Lite ( [code](https://github.com/shkfnly/rails_with_active_record_lite) )

## Week 6
Javascript projects

### Towers of Hanoi ( [code](https://github.com/shkfnly/towers_of_hanoi) )
### Snake ( [code](https://github.com/shkfnly/snake) )
### Asteroids ( [code](https://github.com/shkfnly/asteroids) )
### AjaxTwitter ( [code](https://github.com/shkfnly/AjaxTwitter) )
The main purpose of this project was to write jQuery plugins. The code includes
- `FollowToggle`: a jQuery plugin that turns a button into a toggle that follows/unfollows a user.
- `UsersSearch`: a jQuery plugin that creates real-time user search. On every keypress, as the user types in a username, the page shows the matching users for the current input.
- `TweetCompose`: a jQuery plugin that graphs the new tweet form and installs itself. It also allows us to tag multiple users in a tweet.

## Week 7

### Pokedex ( [code](https://github.com/shkfnly/appacademy/tree/master/w7/w7d2) )

### TrelloClone ( [code](https://github.com/shkfnly/TrelloClone) )


## Final Project ( [code](https://github.com/shkfnly/WaiterUp) | [live](waiterup.com) )

[waiterup.com](waiterup.com)

In short: Yelp for menus.
There are 2 type of users: restaurant managers and customers. Restaurant managers upload their menu to WaiterUp. If a customer walks into that restaurant, he/she can pull up the app on their phone, order from the menu, and then also pay through the app without having to leave tip. The idea is to eliminate waiters.