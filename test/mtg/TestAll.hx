package mtg;

import mtg.core.client.*;
import mtg.core.server.*;
import mtg.core.util.*;
import utest.Assert;
import utest.Runner;
import utest.ui.Report;

class TestAll {
  public static function addTests(runner : Runner) {
    runner.addCase(new TestCardTextParser());
  }

  public static function main() {
    var runner = new Runner();
    addTests(runner);
    Report.create(runner);
    runner.run();
  }
}
