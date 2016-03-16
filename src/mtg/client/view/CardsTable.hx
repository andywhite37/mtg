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
        ])
      ]),
      tbody(
        props.cards.map(function(card) : VChild {
          return tr([
            td(img(["src" => "", "alt" => ""])),
            td(card.name),
            td(new CardTextView({ text: card.manaCost })),
            td(card.type.capitalizeWords()),
            td(card.rarity.capitalizeWords()),
            td(new CardTextView({ text: card.text })),
            td(new CardTextView({ text: card.flavor })),
          ]);
        })
      ),
      tfoot([
      ])
    ]);
  }
}
