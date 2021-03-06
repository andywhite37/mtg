package mtg.client.view;

import doom.html.Html.*;
import doom.core.VNode;
import mtg.core.model.Symbol;
import mtg.core.util.CardTextParser;

class CardTextView extends doom.html.Component<{ text : String }> {
  override function render() {
    var tokens = CardTextParser.parse(props.text);

    return span(["class" => "card-text-container"], tokens.map(function(token) : VNode {
      return switch token {
        case TText(text) : span(["class" => "card-text"], text);
        case TSymbol(symbol) : new SymbolView({ symbol: symbol });
        case TNewline : div(["class" => "card-text-break"]);
      };
    }));
  }
}
