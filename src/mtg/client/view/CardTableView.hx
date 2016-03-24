package mtg.client.view;

import doom.core.*;
import doom.html.Html.*;
import mtg.core.model.*;
using thx.Functions;
using thx.Strings;

class CardTableView extends doom.html.Component<{ cards : Array<Card> }> {
  override function render() : VNode {
    trace('CardTableView.render');
    return div(["class" => "card-table-container"], [
      div(["class" => "ui form"], [
        label("Name"),
        div(["class" => "inline fields"], [
          div(["class" => "eight wide field"], [
            input(["type" => "text", "placeholder" => "Name"]),
          ]),
          div(["class" => "field"], [
            div(["class" => "ui radio checkbox"], [
              input(["type" => "radio", "name" => "namequery", "tabindex" => "0", "class" => "hidden"]),
              label("Exact match")
            ]),
          ]),
          div(["class" => "field"], [
            div(["class" => "ui radio checkbox"], [
              input(["type" => "radio", "name" => "namequery", "tabindex" => "0", "class" => "hidden"]),
              label("Any words")
            ]),
          ]),
          div(["class" => "field"], [
            div(["class" => "ui radio checkbox"], [
              input(["type" => "radio", "name" => "namequery", "tabindex" => "0", "class" => "hidden"]),
              label("All words")
            ])
          ])
        ])
      ]),
      table(["class" => "ui selectable celled table card-table"], [
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
              td(img(["src" => card.getImageUrl(), "alt" => card.name])),
              td(card.name),
              td([
                span([
                  new CardTextView({ text: card.manaCost }).asChild(),
                  span(' (${card.cmc})').asChild(),
                ])
              ]),
              td(card.type.capitalizeWords()),
              td(card.rarity.capitalizeWords()),
              td(new CardTextView({ text: card.text })),
              td(new CardTextView({ text: card.flavor })),
            ]);
          })
        ),
        tfoot([
        ])
      ])
    ]);
  }

  public override function willMount() {
    trace('CardTableView.willMount');
  }

  public override function didMount() {
    trace('CardTableView.didMount');
    untyped new js.jquery.JQuery(element).find(".ui.radio.checkbox").checkbox();
  }

  override function willUpdate() {
    trace('CardTableView.willUpdate');
  }

  override function didUpdate() {
    trace('CardTableView.didUpdate');
  }

  override function willUnmount() {
    trace('CardTableView.willUnmount');
  }

  override function didUnmount() {
    trace('CardTableView.didUnmount');
  }

  override function shouldRender() {
    return true;
  }

  function onSearch() {
  }
}
