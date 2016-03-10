package mtg.client.state;

import mtg.client.state.AppAction;
import mtg.client.state.Data;
import lies.Reduced;

typedef Result = Reduced<AppState, AppAction>;

class Reducer<T> {
  public function new() {
  }

  public function reduce(state : AppState, action : AppAction) : Result {
    return switch action {
      case ShowPage(page) : showPage(state, page);
      case _ : state;
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
    return state;
  }

  function showCardsPage(state : AppState, data : CardsData) : Result {
    return state;
  }
}
