package mtg.client.view;

import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.client.state.Data;

class HomePageView extends doom.html.Component<{ api: AppApi, state: HomePageData }> {
  override function render() {
    return h1('home page');
  }
}
