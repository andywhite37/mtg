package mtg.client.view;

import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.client.state.Data;

class DeckPageView extends doom.html.Component<{ api: AppApi, state: DeckPageData }> {
  override function render() {
    return h1('deck page');
  }
}
