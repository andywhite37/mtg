package mtg.server.route;

import abe.IRoute;
import express.Next;
import express.Response;
import mtg.server.data.Database;
import thx.promise.Promise;
using mtg.server.Config;
using mtg.server.route.ApiRoute;

@:path('/api')
class ApiRoute implements IRoute {
  var database : Database;

  public function new() {
    this.database = new Database(Config.MTG_DATABASE_URL);
  }

  @:get('/')
  function ping() {
    response.send({ status: 'OK' });
  }

  @:get('/cards')
  function getCards() {
    database.getCards().sendData(response, next);
  }

  @:get('/cards/:id')
  @:args(Params)
  function getCard(id : String) {
  }

  @:post('/cards')
  function createCard() {
  }

  @:put('/cards/:id')
  @:args(Params)
  function updateCard() {
  }

  @:get('/editions')
  function getEditions() {
  }

  @:get('/editions/:code')
  @:args(Params)
  function getEdition(code : String) {
  }

  @:post('/editions')
  function createEdition() {
  }

  @:put('/editions')
  function updateEdition() {
  }

  static function sendData<T : {}>(promise : Promise<T>, ?statusCode : Int, response : Response, next : Next) {
    promise
      .success(function(data) {
        if (statusCode == null) statusCode = 200;
        response.status(statusCode).send(data);
      })
      .failure(function(err) {
        next.error(err);
      });
  }
}
