package mtg.server;

import abe.App;
import express.*;
import js.Node;
import js.node.Path;
import mtg.server.error.ErrorHandler;
import mtg.server.error.HttpError;
import mtg.server.route.ApiRoute;

class Main {
  public static inline var DEFAULT_HOST : String = "0.0.0.0";
  public static inline var DEFAULT_PORT : Int = 9999;

  public static function main() {
    var app = new App();
    App.installNpmDependencies();
    app.router.use(mw.Compression.create());
    app.router.use(mw.Morgan.create("common", { immediate: false }));
    app.router.use(mw.Cors.create());
    app.router.register(new ApiRoute());
    app.router.serve('/', Path.join(Node.__dirname, 'public'));
    app.router.use(function(req : Request, res : Response, next : Next) {
      next.error(HttpError.notFound('Not found', None));
    });
    app.router.error(ErrorHandler.handle);
    var host = DEFAULT_HOST;
    var port = DEFAULT_PORT;
    if (Node.process.argv[2] != null) port = Std.parseInt(Node.process.argv[2]);
    app.http(port, host);
    trace('server listening at $host:$port');
  }
}
