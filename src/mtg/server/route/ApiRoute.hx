package mtg.server.route;

import abe.IRoute;

@:path('/api')
class ApiRoute implements IRoute {
  @:get('/')
  function ping() {
    response.send({ status: 'OK' });
  }
}
