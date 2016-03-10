package mtg.client.view;

import mtg.client.state.AppState;
import doom.html.Html.*;

class NavMenu extends doom.html.Component<{ state : AppState }> {
  override function render() {
    var homeLinkClass = "";
    var cardsLinkClass = "";
    var decksLinkClass = "";
    switch props.state.currentPage {
      case Home(_) : homeLinkClass = "active";
      case Cards(_) : cardsLinkClass = "active";
      case Decks(_) : decksLinkClass = "active";
      case _ :
    };
    return div(['class' => 'ui fixed inverted menu'], [
      div(['class' => 'ui container'], [
        div(['class' => 'header item'], 'M.T.G.'),
        a(['class' => '$homeLinkClass item', 'href' => '/#'], 'Home'),
        a(['class' => '$cardsLinkClass item', 'href' => '/#/cards'], 'Cards'),
        a(['class' => '$decksLinkClass item', 'href' => '/#/decks'], 'Decks'),
      ]),
    ]);
  }
}
