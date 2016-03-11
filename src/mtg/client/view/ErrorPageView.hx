package mtg.client.view;

import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.client.state.Data;

class ErrorPageView extends doom.html.Component<{ api: AppApi, state: ErrorPageData }> {
  override function render() {
    return h1('Error: ${props.state.message}');
  }
}
