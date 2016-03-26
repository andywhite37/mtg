package mtg.client.view;

import doom.core.*;
import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.client.state.Data;
import mtg.core.model.Card;

class CardsPageView extends doom.html.Component<{ api: AppApi, state: CardsPageData }> {
  override function render() {
    return div(["class" => "cards-page ui container"], [
      switch props.state {
        case Loading(_) : loading();
        case Loaded(data) : loaded(data);
        case Failed(data) : failed(data);
      }
    ]);
  }

  function loading() {
    return div('loading...');
  }

  function loaded(data : { cards: Array<Card> }) {
    return div([
      h1('Cards'),
      new CardTableView({ cards: data.cards }).asNode(),
    ]);
  }

  function failed(data : ErrorPageData) {
    return h1('failed to load cards: ${data.message}');
  }
}
