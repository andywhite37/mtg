package mtg.client.view;

import doom.core.*;
import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.client.state.Data;
import mtg.core.model.Card;

class CardsPageView extends doom.html.Component<{ api: AppApi, state: CardsPageData }> {
  override function render() {
    return switch props.state {
      case Loading(_) : renderLoading();
      case Loaded(data) : renderLoaded(data);
      case Failed(data) : renderFailed(data);
    };
  }

  function renderLoading() {
    return div('loading...');
  }

  function renderLoaded(data : { cards: Array<Card> }) {
    return div([
      h1('Cards'),
      div(["class" => 'ui link cards'],
        data.cards.map(function(card) : VChild {
          return new CardView({ state: card, api: props.api });
        })
      ),
    ]);
  }

  function renderFailed(data : ErrorPageData) {
    return h1('failed to load cards: ${data.message}');
  }
}
