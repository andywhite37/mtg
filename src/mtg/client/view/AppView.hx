package mtg.client.view;

import doom.core.*;
import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.client.state.AppState;
import mtg.client.state.Data;
import mtg.client.view.*;

class AppView extends doom.html.Component<{ api: AppApi, state: AppState }> {
  override function render() {
    return div([
      navMenu(),
      div(["class" => "ui main container"], [
        contentView(),
      ]),
      div(["class" => "ui inverted vertical footer segment"], [
        div(["class" => "ui center aligned container"], [
          div(["class" => "ui horizontal inverted small divided link list"], [
            a(["class" => "item", "href" => "/#/"], "Home"),
            a(["class" => "item", "href" => "/#/sets"], "Sets"),
            a(["class" => "item", "href" => "/#/cards"], "Cards"),
            a(["class" => "item", "href" => "/#/cards"], "Decks"),
          ])
        ])
      ])
    ]);
  }

  override function willMount() {
    trace('AppView.willMount');
  }

  function navMenu() : VNode {
    return new AppNavView({ state: props.state }).render();
  }

  function contentView() : VNode {
    return switch props.state.currentPage {
      case HomePage(data) : new HomePageView({ state: data, api: props.api }).render();
      case CardsPage(data) : new CardsPageView({ state: data, api: props.api }).render();
      case CardPage(data) : new CardPageView({ state: data, api: props.api }).render();
      case DecksPage(data) : new DecksPageView({ state: data, api: props.api }).render();
      case DeckPage(data) : new DeckPageView({ state: data, api: props.api }).render();
      case ErrorPage(data) : new ErrorPageView({ state: data, api: props.api }).render();
    };
  }
}
