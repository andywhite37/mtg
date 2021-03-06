package mtg.client.state;

import haxe.ds.Option;
import mtg.client.api.ApiClient;
import mtg.client.state.AppAction;
import mtg.client.state.Data;
import mtg.core.model.*;
import lies.Reduced;
import thx.Nil;
import thx.promise.Future;

typedef Result = Reduced<AppState, AppAction>;

class Reducer {
  var apiClient : ApiClient;

  public function new(apiClient : ApiClient) {
    this.apiClient = apiClient;
  }

  public function reduce(state : AppState, action : AppAction) : Result {
    var name = action.getName();
    trace('reduce $name');
    return switch action {
      case ShowPage(page) : showPage(state, page);
      case UpdateCardQuery(cardQuery) : updateCardQuery(state, cardQuery);
      case SubmitCardQuery(cardQuery) : submitCardQuery(state, cardQuery);
    };
  }

  function showPage(state : AppState, page : Page) : Result {
    state = state.setCurrentPage(page);
    return switch page {
      case HomePage(data) : showHomePage(state, data);
      case CardsPage(data) : showCardsPage(state, data);
      case _ : state;
    };
  }

  function showHomePage(state : AppState, data : HomePageData) : Result {
    return switch data {
      case Loading(_) : showHomePageLoading(state);
      case Loaded(data) : state;
      case Failed(data) : state;
    };
  }

  function showHomePageLoading(state : AppState) : Result {
    var future = Future.value(ShowPage(HomePage(Loaded({ decks: [], collections: [] }))));
    return Reduced.fromState(state).withFuture(future);
  }

  function showCardsPage(state : AppState, data : CardsPageData) : Result {
    return switch data {
      case Loading(data) : showCardsPageLoading(state, data);
      case _ : state;
    };
  }

  function showCardsPageLoading(state : AppState, data : { cardQuery : CardQuery }) : Result {
    var loadingCards = apiClient.getCards(data)
      .mapEitherFuture(function(cards) {
        return Future.value(ShowPage(CardsPage(Loaded({ cardQuery: data.cardQuery, cards: cards }))));
      }, function(error) {
        return Future.value(ShowPage(ErrorPage({ message: error.message })));
      });
    return Reduced.fromState(state).withFuture(loadingCards);
  }

  function updateCardQuery(state : AppState, cardQuery : CardQuery) : Result {
    return switch state.currentPage {
      case CardsPage(Loaded(data)) : state.updateCurrentPage(CardsPage(Loaded({ cardQuery: cardQuery, cards: data.cards })));
      case _ : state;
    };
  }

  function submitCardQuery(state : AppState, cardQuery : CardQuery) : Result {
    /*
    var loadingCards = apiClient.getCards({ cardQuery: cardQuery })
      .mapEitherFuture(function(cards) {
        return Future.value(ShowPage(CardsPage(Loaded({ cardQuery: cardQuery, cards: cards }))));
      }, function(error) {
        return Future.value(ShowPage(ErrorPage({ message: error.message })));
      });
    return Reduced.fromState(state).withFuture(loadingCards);
    */
    trace(js.Browser.location.hash);
    js.Browser.location.hash = '/cards?${cardQuery.toQueryString()}';
    return state;
  }
}
