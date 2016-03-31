package mtg.client.view;

import doom.core.*;
import doom.html.Html.*;
import js.jquery.JQuery;
import js.html.InputElement;
import mtg.client.api.AppApi;
import mtg.client.state.AppAction;
import mtg.core.model.Card;
import mtg.core.model.CardQuery;
import mtg.core.model.CardQuery.TextQuery;
using thx.Functions;
using thx.Strings;

class CardTableView extends doom.html.Component<{ api: AppApi, cardQuery : CardQuery, cards : Array<Card> }> {
  override function render() : VNode {
    trace('CardTableView.render ${props.cardQuery.textQuery}');
    return div(["class" => "card-table-container"], [
      form(["class" => "ui form", "submit" => onSearch], [
        label("Text search"),
        div(["class" => "inline fields"], [

          div(["class" => "eight wide field"], [
            input([
              "type" => "text",
              "placeholder" => "Text search",
              "value" => props.cardQuery.textQueryText(),
              "change" => onTextQueryChange
            ]),
          ]),

          div(["class" => "field"], [
            div(["class" => "ui radio checkbox"], [
              input([
                "type" => "radio",
                "name" => "text-query",
                "tabindex" => "0",
                "class" => "hidden",
                "checked" => props.cardQuery.textQueryIsExact(),
                "change" => onTextQueryTypeChange.bind(ExactMatch(props.cardQuery.textQueryText())),
              ]),
              label("Exact match")
            ]),
          ]),

          div(["class" => "field"], [
            div(["class" => "ui radio checkbox"], [
              input([
                "type" => "radio",
                "name" => "text-query",
                "tabindex" => "0",
                "class" => "hidden",
                "checked" => props.cardQuery.textQueryIsStartsWith(),
                "change" => onTextQueryTypeChange.bind(StartsWith(props.cardQuery.textQueryText())),
              ]),
              label("Starts with")
            ]),
          ]),

          div(["class" => "field"], [
            div(["class" => "ui radio checkbox"], [
              input([
                "type" => "radio",
                "name" => "text-query",
                "tabindex" => "0",
                "class" => "hidden",
                "checked" => props.cardQuery.textQueryIsEndsWith(),
                "change" => onTextQueryTypeChange.bind(EndsWith(props.cardQuery.textQueryText())),
              ]),
              label("Ends with")
            ]),
          ]),

          div(["class" => "field"], [
            div(["class" => "ui radio checkbox"], [
              input([
                "type" => "radio",
                "name" => "text-query",
                "tabindex" => "0",
                "class" => "hidden",
                "checked" => props.cardQuery.textQueryIsAny(),
                "change" => onTextQueryTypeChange.bind(ContainsAny(props.cardQuery.textQueryText())),
              ]),
              label("Any words")
            ]),
          ]),

          div(["class" => "field"], [
            div(["class" => "ui radio checkbox"], [
              input([
                "type" => "radio",
                "name" => "text-query",
                "tabindex" => "0",
                "class" => "hidden",
                "checked" => props.cardQuery.textQueryIsAll(),
                "change" => onTextQueryTypeChange.bind(ContainsAll(props.cardQuery.textQueryText())),
              ]),
              label("All words")
            ])
          ])
        ]),
        button(["class" => "ui button", "type" => "submit"], "Submit"),

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

  public override function didMount() {
    untyped new js.jquery.JQuery(element).find(".ui.radio.checkbox").checkbox();
  }

  override function willUnmount() {
  }

  function onTextQueryChange(el : InputElement) {
    trace('text query change');
    /*
    props.cardQuery.textQuery = switch props.cardQuery.textQuery {
      case ExactMatch(_) : ExactMatch(el.value);
      case StartsWith(_) : StartsWith(el.value);
      case EndsWith(_) : EndsWith(el.value);
      case ContainsAny(_) : ContainsAny(el.value);
      case ContainsAll(_) : ContainsAll(el.value);
      case None : None;
    };
    */
    props.cardQuery.textQuery = ExactMatch(el.value);
    props.api.dispatch(UpdateCardQuery(props.cardQuery));
  }

  function onTextQueryTypeChange(textQuery : TextQuery) {
    props.cardQuery.textQuery = textQuery;
    props.api.dispatch(UpdateCardQuery(props.cardQuery));
  }

  function onSearch() {
    trace('submit');
    props.api.dispatch(SubmitCardQuery(props.cardQuery));
  }
}
