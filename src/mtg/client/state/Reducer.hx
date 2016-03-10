package mtg.client.state;

import mtg.client.api.ApiClient;
import mtg.client.state.AppAction;
import mtg.client.state.Data;
import lies.Reduced;
import thx.promise.Future;

typedef Result = Reduced<AppState, AppAction>;

class Reducer {
  var apiClient : ApiClient;

  public function new(apiClient : ApiClient) {
    this.apiClient = apiClient;
  }

  public function reduce(state : AppState, action : AppAction) : Result {
    return switch action {
      case ShowPage(page) : showPage(state, page);
    };
  }

  function showPage(state : AppState, page : Page) : Result {
    state.currentPage = page;
    return switch page {
      case Home(data) : showHomePage(state, data);
      case Cards(data) : showCardsPage(state, data);
      case _ : state;
    };
  }

  function showHomePage(state : AppState, data : HomeData) : Result {
    return switch data {
      case Loading(loadingData) : Reduced.fromState(state).withFuture(loadHomeData());
      case Loaded(loadedData) : state;
      case Failed(failedData) : state;
    };
  }

  function loadHomeData() : Future<AppAction> {
    return Future.value(ShowPage(Home(Loaded({ decks: [], collections: [] }))));
  }

  function showCardsPage(state : AppState, data : CardsData) : Result {
    return state;
  }
}
