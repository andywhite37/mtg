package mtg.client.view;

import mtg.client.state.AppState;
import doom.html.Html.*;

class NavMenu extends doom.html.Component<{ state : AppState }> {
  override function render() {
    var homeLinkClass = "";
    var cardsLinkClass = "";
    switch props.state.currentPage {
      case Home(_) : homeLinkClass = "active";
      case Cards(_) : cardsLinkClass = "active";
      case _ :
    };
    return div(['class' => 'ui fixed inverted menu'], [
      div(['class' => 'ui container'], [
        a(['class' => 'header item', 'href' => '/#'], 'MTG'),
        a(['class' => '$homeLinkClass item', 'href' => '/#'], 'Home'),
        a(['class' => '$cardsLinkClass item', 'href' => '/#/cards'], 'Cards'),
      ]),
    ]);
  }
}
