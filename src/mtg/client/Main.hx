package mtg.client;

import Doom;
import js.jquery.JQuery;
import lies.Store;
import mtg.client.api.ApiClient;
import mtg.client.api.AppApi;
import mtg.client.state.AppAction;
import mtg.client.state.AppState;
import mtg.client.state.Reducer;
import mtg.client.view.AppView;
import routly.RouteDescriptor;
import routly.Routly;
import thx.Nil;

class Main {
  public static function main() {
    var apiClient = new ApiClient();
    var appState = new AppState();
    var appApi = new AppApi();
    var reducer = new Reducer();
    var store : Store<AppState, AppAction> = Store.create(reducer.reduce, appState);
    var router = setupRouter(store);
    var appComponent = new AppView({ api: appApi, state: appState });
    store.subscribe(function(newState, oldState, action) {
      appComponent.update({ state: newState, api: appApi });
    });
    Doom.browser.mount(appComponent, dots.Query.find("#root"));
    router.listen(true);
  }

  static function setupRouter(store : Store<AppState, AppAction>) : Routly {
    var router = new Routly();
    router.routes([
      "/" => function(descriptor : RouteDescriptor) {
        store.dispatch(ShowPage(Home(Loading(nil))));
      },
      "/cards" => function(descriptor : RouteDescriptor) {
        store.dispatch(ShowPage(Cards(Loading(nil))));
      },
      "/card/:id" => function(descriptor : RouteDescriptor) {
        var cardId = descriptor.arguments["id"];
        store.dispatch(ShowPage(Card(Loading(cardId))));
      },
    ]);
    router.unknown(function(descriptor : RouteDescriptor) {
      var raw = descriptor.raw;
      store.dispatch(ShowPage(NotFound({ message: '$raw was not found' })));
    });
    return router;
  }
}
