package mtg.client.state;

import haxe.ds.Option;
import mtg.client.state.Page;
import thx.Nil;

class AppState {
  public var currentPage : Page;

  public function new() {
    currentPage = Home(Loading(nil));
  }

  public function isHomePage() : Bool {
    return switch currentPage {
      case Home(_) : true;
      case _ : false;
    };
  }
}
