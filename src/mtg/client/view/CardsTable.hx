package mtg.client.view;

import doom.core.*;
import doom.html.Html.*;
import mtg.core.model.*;
using thx.Functions;
using thx.Strings;

class CardsTable extends doom.html.Component<{ cards : Array<Card> }> {
  override function render() : VNode {
    return table(["class" => "ui selectable celled table cards-table"], [
      thead([
        tr([
          th(["class" => "image"], "Image"),
          th(["class" => "name"], "Name"),
          th(["class" => "cost"], "Cost"),
          th(["class" => "types"], "Types"),
          th(["class" => "rarity"], "Rarity"),
          th(["class" => "text"], "Card text"),
          th(["class" => "flavor"], "Flavor text"),
          th(["class" => "store-link"], "Store"),
        ])
      ]),
      tbody(
        props.cards.map(function(card) : VChild {
          var edition = card.getLatestEdition();
          var imageInfo = card.getLatestImage();
          return tr([
            td(img(["src" => imageInfo.src, "alt" => imageInfo.alt])),
            td(card.name),
            td(new CardTextView({ text: card.cost })),
            td(card.types.map.fn(_.capitalizeWords()).join(', ')),
            td(edition.rarity.capitalizeWords()),
            td(new CardTextView({ text: card.text })),
            td(new CardTextView({ text: edition.flavor })),
            td(a(["href" => card.storeUrl, "target" => "_blank"], "TCGPlayer")),
          ]);
        })
      ),
      tfoot([
      ])
    ]);
  }
}
