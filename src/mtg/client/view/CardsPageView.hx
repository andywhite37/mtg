package mtg.client.view;

import doom.core.*;
import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.client.state.Data;
import mtg.core.model.Card;

class CardsPageView extends doom.html.Component<{ api: AppApi, state: CardsPageData }> {
  override function render() {
    trace('CardsPageView.render');
    return switch props.state {
      case Loading(_) : renderLoading();
      case Loaded(data) : renderLoaded(data);
      case Failed(data) : renderFailed(data);
    };
  }

  override function willMount() {
    super.willMount();
    trace('CardsPageView.willMount');
  }

  override function didMount() {
    super.didMount();
    trace('CardsPageView.didMount');
  }

  override function willUpdate() {
    trace('CardsPageView.willUpdate');
  }

  override function didUpdate() {
    trace('CardsPageView.didUpdate');
  }

  override function willUnmount() {
    trace('CardsPageView.willUnmount');
  }

  override function didUnmount() {
    trace('CardsPageView.didUnmount');
  }

  function renderLoading() {
    return div('loading...');
  }

  function renderLoaded(data : { cards: Array<Card> }) {
    return div([
      h1('Cards').asChild(),
      new CardTableView({ cards: data.cards }).asChild(),
    ]);
  }

  function renderFailed(data : ErrorPageData) {
    return h1('failed to load cards: ${data.message}');
  }
}
