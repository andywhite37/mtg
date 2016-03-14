package mtg.core.util;

import haxe.ds.Option;
import mtg.core.model.Symbol;

enum CardTextToken {
  TText(text : String);
  TSymbol(symbol : Symbol);
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
    //trace(input);
    if (input == '' || input == null) {
      return [TText('')];
    }
    var tokens = [];
    while (index < input.length) {
      tokens.push(readToken());
    }
    return tokens;
  }

  function readToken() : CardTextToken {
    return if (char() == '{') {
      readSymbolToken();
    } else {
      readTextToken();
    }
  }

  function readTextToken() : CardTextToken {
    return TText(readUpTo('{'));
  }

  function readSymbolToken() : CardTextToken {
    var token = readChar('{');
    token += readUpTo('}');
    token += readChar('}');
    return switch Symbol.safeParse(token) {
      case Some(symbol) : TSymbol(symbol);
      case None : TText(token);
    };
  }

  function readChar(c : String) : String {
    if (char() == c) {
      index++;
    }
    return c;
  }

  function readUpTo(c : String) : String {
    var startIndex = index;
    while (char() != c && index < input.length) {
      index++;
    }
    var result = input.substring(startIndex, index);
    return result;
  }

  function char() : String {
    return input.charAt(index);
  }
}
