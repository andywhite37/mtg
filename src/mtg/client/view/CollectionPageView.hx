package mtg.client.view;

import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.client.state.Data;

class CollectionPageView extends doom.html.Component<{ api: AppApi, state: CollectionPageData }> {
  override function render() {
    return h1('collection page');
  }
}
