package mtg.server.route;

import abe.IRoute;
import express.Next;
import express.Response;
import mtg.core.model.*;
import mtg.server.data.Database;
import mtg.server.error.*;
import thx.promise.Promise;
using mtg.server.Config;
using mtg.server.route.ApiRoute;
using dataclass.Converter;
using dataclass.DataClass;

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
    var cardQuery = CardQuery.fromObject(request.query);
    database.getCards(cardQuery).sendData(response, next);
  }

  @:head('/cards/:id')
  @:args(Params)
  function headCard(id : String) {
    database.hasCardById(id).sendEmptyExists(response, next);
  }

  @:get('/cards/:id')
  @:args(Params)
  function getCard(id : String) {
    database.getCardById(id).sendData(response, next);
  }

  @:post('/cards')
  @:use(mw.BodyParser.json())
  function createCard() {
    var card = new Card(cast request.body);
    database.createCard(card).sendData(201, response, next);
  }

  @:put('/cards/:id')
  @:use(mw.BodyParser.json())
  @:args(Params)
  function updateCard(id : String) {
    var card = new Card(cast request.body);
    if (id != card.id) {
      next.error(new ValidationError('Card id $id in URL does not match card id ${card.id} in request body'));
      return;
    }
    database.updateCard(card).sendData(200, response, next);
  }

  @:delete('/cards/:id')
  @:args(Params)
  function deleteCard(id : String) {
    database.deleteCardById(id).sendEmpty(response, next);
  }

  @:get('/sets')
  function getSets() {
    return database.getSets().sendData(response, next);
  }

  @:head('/sets/:code')
  @:args(Params)
  function headSet(code : String) {
    return database.hasSetByCode(code).sendEmptyExists(response, next);
  }

  @:get('/sets/:code')
  @:args(Params)
  function getSet(code : String) {
    return database.getSetByCode(code).sendData(response, next);
  }

  @:post('/sets')
  @:use(mw.BodyParser.json())
  function createSet() {
    var set = new Set(cast request.body);
    database.createSet(set).sendData(201, response, next);
  }

  @:put('/sets/:code')
  @:use(mw.BodyParser.json())
  @:args(Params)
  function updateSet(code : String) {
    var set = new Set(cast request.body);
    if (code != set.code) {
      next.error(new ValidationError('Set code $code in URL does not match set code ${set.code} in request body'));
      return;
    }
    database.updateSet(set).sendData(response, next);
  }

  @:delete('/sets/:code')
  @:args(Params)
  function deleteSet(code : String) {
    database.deleteSetByCode(code).sendEmpty(response, next);
  }

  @:head('/sets/:code/cards/:id')
  @:args(Params)
  function headSetCard(code : String, id : String) {
    database.hasSetCard(code, id).sendEmptyExists(response, next);
  }

  @:post('/sets/:code/cards/:id')
  @:args(Params)
  function createSetCard(code : String, id : String) {
    database.createSetCard(code, id).sendEmpty(response, next);
  }

  @:delete('/sets/:code/cards/:id')
  @:args(Params)
  function deleteSetCard(code : String, id : String) {
    database.deleteSetCard(code, id).sendEmpty(response, next);
  }

  @:put('/card-rankings')
  function putCardRankings() {
    database.rankCards().sendEmpty(response, next);
  }

  static function sendData<T>(promise : Promise<T>, ?statusCode : Int = 200, response : Response, next : Next) : Void {
    promise
      .success(function(data) {
        response.status(statusCode).send(cast data);
      })
      .failure(function(err) {
        next.error(err);
      });
  }

  static function sendEmpty<T>(promise : Promise<T>, ?statusCode : Int = 204, response : Response, next : Next) : Void {
    promise
      .success(function(_) {
        response.sendStatus(statusCode);
      })
      .failure(function(err) {
        next.error(err);
      });
  }

  static function sendEmptyExists(promise : Promise<Bool>, response : Response, next : Next) : Void {
    promise
      .success(function(exists) {
        var statusCode = exists ? 204 : 404;
        response.sendStatus(statusCode);
      })
      .failure(function(err) {
        next.error(err);
      });
  }
}
