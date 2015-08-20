describe("Pokedex.Models.Pokemon", function() {
  it("has a urlRoot property", function() {
    var poke = new Pokedex.Models.Pokemon();
    expect(poke.urlRoot).toEqual('/pokemon');

    poke.set('id', 1);
    expect(poke.url()).toEqual('/pokemon/1');
  });
});

describe("Pokedex.Collections.Pokemon", function() {
  beforeEach(function() {
    this.pokeCollection = new Pokedex.Collections.Pokemon();
  });

  it("knows its model", function() {
    expect(this.pokeCollection.model).toEqual(Pokedex.Models.Pokemon);
  });

  it("knows its url", function() {
    expect(this.pokeCollection.url).toEqual('/pokemon');
  });
});

describe("listPokemon", function() {

// AR: alternative way to check for 'fetch' call below
//it("fetches the passed-in collection", function() {
//  var pokedex = new Pokedex();
//  var pokes = new Pokedex.Collections.Pokemon();

//  var eventSpy = sinon.spy();
//  pokes.on('request', eventSpy);

//  pokedex.listPokemon(pokes, function() {});
//  expect(eventSpy.calledOnce).toBeTruthy();
//});
  
  it("fetches the passed-in collection", function() {
    var pokedex = new Pokedex($('<div>'));
    
    this.server = sinon.fakeServer.create();
    pokedex.listPokemon(function() {});

    expect(this.server.requests.length)
      .toEqual(1);
    expect(this.server.requests[0].method)
      .toEqual("GET");
    expect(this.server.requests[0].url)
      .toEqual("/pokemon");
  });

  it("fills the passed-in collection", function() {
    
    var pokedex = new Pokedex($('<div>'));

    this.fixture = this.fixtures.Pokemon.index.response;
    this.server = sinon.fakeServer.create();
    this.server.respondWith(
      "GET",
      "/pokemon",
      [
        200,
        {"Content-Type": "application/json"},
        JSON.stringify(this.fixture)
      ]
    );

    pokedex.listPokemon(function() {});
    this.server.respond();
    // check number of pokemon on success - should be 3
    expect(pokedex.pokes.length).toEqual(this.fixture.length);
  });

  describe("calling the callback function", function() {

    beforeEach(function () {
      this.called = false;
      this.pokedex = new Pokedex($('<div>'));

      this.fixture = this.fixtures.Pokemon.index.response;
      this.server = sinon.fakeServer.create();
      this.server.respondWith(
        "GET",
        "/pokemon",
        [
          200,
          {"Content-Type": "application/json"},
          JSON.stringify(this.fixture)
        ]
      );
      
      var that = this;
      this.pokedex.listPokemon(function() {
        that.called = true;
      });
    });

    afterEach(function() {
      this.server.restore();
    });

    it("calls the callback function", function() {
      this.server.respond();
      expect(this.called).toBeTruthy();
    });

    it("waits to call the callback until the collection has been filled", 
          function() {

      expect(this.called).toBeFalsy();

      this.server.respond();
      expect(this.called).toBeTruthy();
      expect(this.pokedex.pokes.length).toEqual(this.fixture.length);
    });
  });
});

describe("createPokemon", function() {
  beforeEach(function() {
    this.server = sinon.fakeServer.create();

    this.pokedex = new Pokedex($('<div>'));
  });

  afterEach(function() {
    this.server.restore();
  });
  
  it("returns a Pokemon model", function() {
    var poke = this.pokedex.createPokemon();
    expect(poke.__proto__).toEqual(Pokedex.Models.Pokemon.prototype);
  });  

  it("gives returned model the right attritbutes", function() {
    var poke = this.pokedex.createPokemon({name: "Pikachu", number: 25});
    expect(poke.get('name')).toEqual("Pikachu");
    expect(poke.get('number')).toEqual(25);
  });

  it("sends the correct HTTP request to the server", function() {
    this.pokedex.createPokemon(); 
    
    expect(this.server.requests.length)
      .toEqual(1);
    expect(this.server.requests[0].method)
      .toEqual("POST");
    expect(this.server.requests[0].url)
      .toEqual("/pokemon");
  });

  it("adds the model to Pokedex collection", function() {
    // do we want to have a global collection defined on Pokedex?
    // e.g., new Pokedex().pokes = new Pokedex.Collections.Pokemon();
    
    // I would like createPokemon to add the model to a collection,
    // so that students can do this with Collection#create, and maybe
    // experience using {wait: true} 
    //this.pokedex.createPokemon({ name: "Pikachu", number: 25 });

    //this.server.respond();
    //expect(this.pokedex.pokes.length).toEqual(1);
  });
});
