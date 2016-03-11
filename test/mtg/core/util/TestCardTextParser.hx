package mtg.core.util;

import mtg.core.model.ManaSymbol;
import mtg.core.util.CardTextParser;
import mtg.core.util.CardTextParser.CardTextToken;
import utest.Assert;
using thx.Ints;

class TestCardTextParser {
  public function new() {}

  public function testParse() {
    assertTokens([CText('hi '), CManaSymbol('{W}'), CText(' bye')], 'hi {W} bye');
  }

  function assertTokens(expected : Array<CardTextToken>, input : String) {
    var actual = CardTextParser.parse(input);
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
