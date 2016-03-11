package mtg.client.view;

import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.client.state.Data;

class DecksPageView extends doom.html.Component<{ api: AppApi, state: DecksPageData }> {
  override function render() {
    return h1('decks page');
  }
}
