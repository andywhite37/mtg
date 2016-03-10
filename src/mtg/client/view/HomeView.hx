package mtg.client.view;

import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.client.state.Data;

class HomeView extends doom.html.Component<{ api: AppApi, state: HomeData }> {
  override function render() {
    return h1('home');
  }
}
