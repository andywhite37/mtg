package mtg.client.api;

import lies.Store;
import mtg.client.state.AppState;
import mtg.client.state.AppAction;

class AppApi {
  var store : Store<AppState, AppAction>;

  public function new(store) {
    this.store = store;
  }

  public function dispatch(action : AppAction) {
    store.dispatch(action);
  }
}
