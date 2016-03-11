package mtg.core.util;

import mtg.core.model.ManaSymbol;

enum CardTextToken {
  CText(text : String);
  CManaSymbol(manaSymbol : ManaSymbol);
}

class CardTextParser {
  var input : String;
  var index : Int;

  private function new(input : String) {
    this.input = input;
    this.index = 0;
  }

  public static function parse(input : String) : Array<CardTextToken> {
    return new CardTextParser(input).internalParse();
  }

  function internalParse() : Array<CardTextToken> {
    var tokens = [];
    while (index < input.length) {
      tokens.push(readToken());
    }
    return tokens;
  }

  function readToken() : CardTextToken {
    return if (char() == '{') {
      readManaSymbolToken();
    } else {
      readTextToken();
    }
  }

  function readTextToken() : CardTextToken {
    return CText(readUpTo('{'));
  }

  function readManaSymbolToken() : CardTextToken {
    var result = readChar('{');
    result += readUpTo('}');
    result += readChar('}');
    return CManaSymbol(result);
  }

  function readChar(c : String) : String {
    if (char() == c) {
      index++;
    }
    return c;
  }

  function readUpTo(c : String) : String {
    var startIndex = index;
    while (char() != c) {
      index++;
    }
    var result = input.substring(startIndex, index);
    trace(result);
    return result;
  }

  function char() : String {
    return input.charAt(index);
  }
}
