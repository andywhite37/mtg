package mtg.core.util;

import mtg.core.model.Symbol;
import mtg.core.util.CardTextParser;
import mtg.core.util.CardTextParser.CardTextToken;
import utest.Assert;
using thx.Ints;

class TestCardTextParser {
  public function new() {}

  public function testParse() {
    assertTokens([TText('')], '');

    assertTokens([TText(' ')], ' ');

    assertTokens([TText('{ZZZ}')], '{ZZZ}');

    assertTokens([
      TText('hi '),
      TSymbol('{W}'),
      TText(' bye')
    ], 'hi {W} bye');

    assertTokens([
      TSymbol('{1}'),
      TSymbol('{B}'),
      TSymbol('{R}'),
      TSymbol('{R/G}')
    ], '{1}{B}{R}{R/G}');

    assertTokens([
      TText(' '),
      TSymbol('{1}'),
      TText(' '),
      TSymbol('{B}'),
      TText(' '),
      TSymbol('{R}'),
      TText(' '),
      TSymbol('{R/G}'),
      TText(' '),
    ], ' {1} {B} {R} {R/G} ');

    assertTokens([
      TText('some text '),
      TSymbol('{1}'),
      TSymbol('{W}'),
      TText(' some more text '),
      TSymbol('{X}'),
      TText(', '),
      TSymbol('{1}'),
      TSymbol('{B}'),
      TText(' end.'),
    ], 'some text {1}{W} some more text {X}, {1}{B} end.');
  }

  function assertTokens(expected : Array<CardTextToken>, input : String) {
    var actual = CardTextParser.parse(input);
    //trace(actual);
    if (expected.length != actual.length) {
      Assert.fail('mismatched length');
    }
    for (i in expected.length.range()) {
      var exp = expected[i];
      var act = actual[i];
      var isEqual = switch [exp, act] {
        case [TText(l), TText(r)] : l == r;
        case [TSymbol(l), TSymbol(r)] : l == r;
        case _ : false;
      };
      Assert.isTrue(isEqual);
    }
  }
}
