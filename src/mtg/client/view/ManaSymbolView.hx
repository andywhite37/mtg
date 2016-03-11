package mtg.client.view;

class ManaSymbolView extends doom.html.Component<{ manaSymbol : ManaSymbol }> {
  override function render() {
    var fileName = switch state.manaSymbol {
      case W : "white.jpeg";
    };
    var src = '/assets/mana/$fileName';
    var alt = state.manaSymbol;
    return image(["src" => src, "alt" => alt ]);
  }
}
