package mtg.client.view;

import doom.core.*;
import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.client.state.AppState;
import mtg.client.state.Data;
import mtg.client.view.HomeView;

class AppView extends doom.html.Component<{ api: AppApi, state: AppState }> {
  override function render() {
    return div([
      navMenu(),
      div(["class" => "ui main container"], [
        contentView(),
      ])
    ]);
  }

  function navMenu() : VNode {
    return new NavMenu({ state: props.state }).render();
  }

  function contentView() : VNode {
    return switch props.state.currentPage {
      case Home(data) : new HomeView({ state: data, api: props.api }).render();
      case Cards(_) : h1("cards");
      case Card(_) : h1("card");
      case Decks(_) : h1("decks");
      case Deck(_) : h1("deck");
      case Collections(_) : h1("collections");
      case Collection(_) : h1("collection");
      case NotFound(data) : h1('${data.message}');
    };
  }
}
