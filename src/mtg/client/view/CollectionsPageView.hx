package mtg.client.view;

import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.client.state.Data;

class CollectionsPageView extends doom.html.Component<{ api: AppApi, state: CollectionsPageData }> {
  override function render() {
    return h1('collections page');
  }
}
