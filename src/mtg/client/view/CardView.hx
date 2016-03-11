package mtg.client.view;

import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.core.model.*;

class CardView extends doom.html.Component<{ api : AppApi, state: Card }> {
  override function render() {
    return div([
      h1(props.state.name),
    ]);
  }
}
