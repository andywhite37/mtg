package mtg.client.view;

import doom.core.*;
import doom.html.Html.*;
import js.jquery.JQuery;
import mtg.core.model.*;
using thx.Functions;
using thx.Strings;

class CardTableView extends doom.html.Component<{ cards : Array<Card> }> {
  override function render() : VNode {
    trace('CardTableView.render');
    return div(["class" => "card-table-container"], [
      form(["class" => "ui form"], [
        label("Name"),
        div(["class" => "inline fields"], [
          div(["class" => "eight wide field"], [
            input(["type" => "text", "placeholder" => "Card name search"]),
          ]),
          div(["class" => "field"], [
            div(["class" => "ui radio checkbox"], [
              input(["type" => "radio", "name" => "name-query", "tabindex" => "0", "class" => "hidden"]),
              label("Exact match")
            ]),
          ]),
          div(["class" => "field"], [
            div(["class" => "ui radio checkbox"], [
              input(["type" => "radio", "name" => "name-query", "tabindex" => "0", "class" => "hidden"]),
              label("Starts with")
            ]),
          ]),
          div(["class" => "field"], [
            div(["class" => "ui radio checkbox"], [
              input(["type" => "radio", "name" => "name-query", "tabindex" => "0", "class" => "hidden"]),
              label("Any words")
            ]),
          ]),
          div(["class" => "field"], [
            div(["class" => "ui radio checkbox"], [
              input(["type" => "radio", "name" => "name-query", "tabindex" => "0", "class" => "hidden"]),
              label("All words")
            ])
          ])
        ])
      ]),
      table(["class" => "ui selectable celled table card-table"], [
        thead([
          tr([
            th(["class" => "image"], "Image"),
            th(["class" => "cost"], "Cost"),
            th(["class" => "name"], "Name"),
            th(["class" => "type"], "Type"),
            th(["class" => "power-toughness"], "P/T"),
            th(["class" => "text"], "Card text"),
            th(["class" => "flavor"], "Flavor text"),
            th(["class" => "rarity"], "Rarity"),
          ])
        ]),
        tbody(
          props.cards.map(function(card) {
            return tr([
              td(["class" => "image"], img(["src" => card.getImageUrl(), "alt" => card.name])),
              td(["class" => "cost"], new CardTextView({ text: card.getManaCostAndCmc() })),
              td(["class" => "name"], card.name),
              td(["class" => "type"], card.type.capitalizeWords()),
              td(["class" => "power-toughness"], card.getPowerToughness()),
              td(["class" => "text"], new CardTextView({ text: card.text })),
              td(["class" => "flavor"], new CardTextView({ text: card.flavor })),
              td(["class" => "rarity"], card.rarity.capitalizeWords()),
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
