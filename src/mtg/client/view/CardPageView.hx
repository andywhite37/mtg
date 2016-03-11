package mtg.client.view;

import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.client.state.Data;

class CardPageView extends doom.html.Component<{ api: AppApi, state: CardPageData }> {
  override function render() {
    return h1('card page');
  }
}
