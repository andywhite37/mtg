package mtg.server.route;

import abe.IRoute;

@:path('/api')
class ApiRoute implements IRoute {
  static inline var deckBrewBaseUrl = 'https://api.deckbrew.com/mtg';

  @:get('/')
  function ping() {
    response.send({ status: 'OK' });
  }

  @:get('/cards/:id')
  @:args(Params)
  function getCard(id : String) {
    response.redirect(307, '$deckBrewBaseUrl/cards/$id');
  }

  @:get('/cards')
  function getCards() {
    response.redirect(307, '$deckBrewBaseUrl/cards');
  }
}
