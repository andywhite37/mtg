package mtg.core.util;

import mtg.core.model.ManaSymbol;
import mtg.core.util.CardTextParser;
import mtg.core.util.CardTextParser.CardTextToken;
import utest.Assert;
using thx.Ints;

class TestCardTextParser {
  public function new() {}

  public function testParse() {
    assertTokens([CText('')], '');

    assertTokens([CText(' ')], ' ');

    assertTokens([
      CText('hi '),
      CManaSymbol('{W}'),
      CText(' bye')
    ], 'hi {W} bye');

    assertTokens([
      CManaSymbol('{1}'),
      CManaSymbol('{B}'),
      CManaSymbol('{R}'),
      CManaSymbol('{R/B}')
    ], '{1}{B}{R}{R/B}');

    assertTokens([
      CText(' '),
      CManaSymbol('{1}'),
      CText(' '),
      CManaSymbol('{B}'),
      CText(' '),
      CManaSymbol('{R}'),
      CText(' '),
      CManaSymbol('{R/B}'),
      CText(' '),
    ], ' {1} {B} {R} {R/B} ');

    assertTokens([
      CText('some text '),
      CManaSymbol('{1}'),
      CManaSymbol('{W}'),
      CText(' some more text '),
      CManaSymbol('{X}'),
      CText(', '),
      CManaSymbol('{1}'),
      CManaSymbol('{B}'),
      CText(' end.'),
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
        case [CText(l), CText(r)] : l == r;
        case [CManaSymbol(l), CManaSymbol(r)] : l == r;
        case _ : false;
      };
      Assert.isTrue(isEqual);
    }
  }
}
